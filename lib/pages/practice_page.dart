import 'dart:async';

import 'package:jian_ti/dataClass/data_manager.dart';
import 'package:jian_ti/common/my_button.dart';
import 'package:jian_ti/common/info_bar.dart';
import 'package:jian_ti/common/my_toast.dart';
import 'package:jian_ti/dataClass/problem.dart';
import 'package:jian_ti/dataClass/section.dart';
import 'package:flutter/material.dart';

import '../dataClass/subject.dart';

/// 做题页面
// ignore: must_be_immutable
class PracticePage extends StatefulWidget {
  int subjectIndex;
  Section section;
  PracticePage(this.subjectIndex, this.section, {Key? key}) : super(key: key);

  @override
  State<PracticePage> createState() =>
      // ignore: no_logic_in_create_state
      _PracticePageState(subjectIndex: subjectIndex, section: section);
}

class _PracticePageState extends State<PracticePage> {
  late MyToast myToast;
  late Subject subject;
  int subjectIndex;
  Section section;
  List<int> selectedIndexBox = [];
  Problem? problem;

  ///是否显示答案
  bool isShowASW = false;

  /// Practice页面的提交答案流
  var submitStream = StreamController();

  _PracticePageState({required this.subjectIndex, required this.section}) {
    subject = DataManager.subjects[subjectIndex];
  }

  /// 将选择选项下标，转换为字符串---'ABCD'的样式
  String _parseSelectedIndex() {
    selectedIndexBox.sort();
    String str = '';
    for (var element in selectedIndexBox) {
      str += String.fromCharCode(element + 65);
    }
    return str;
  }

  @override
  void initState() {
    problem = section.getProblem();

    /// 监听提交按钮，判断答案
    submitStream.stream.listen((event) {
      if (event == 1) {
        String asw = _parseSelectedIndex();
        if (problem!.key == asw) {
          subject.faultBook.wellDoneProblem(problem);
          changeToNext();
        } else {
          subject.faultBook.addWrongQuestion(problem);
          showAsw();
        }
      }
    });

    /// 添加 toast
    myToast = MyToast(context);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildQuestionView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        section.getProblem()!.title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  /// 显示答案
  void showAsw() {
    setState(() {
      isShowASW = true;
    });
  }

  /// 下一题
  void changeToNext() {
    setState(() {
      if (section.progress < section.problems!.length) {
        section.progress++;
      } else {
        //to do 弹出提示
        showToast('做完了！');
      }

      problem = section.getProblem();
      selectedIndexBox.clear();
      isShowASW = false;
      DataManager.storeData();
    });
  }

  /// 返回上一题
  void backToPre() {
    setState(() {
      if (section.progress > 0) {
        section.progress--;
      } else {
        // to do: 提示不能向前
        myToast.showToast('不能再前进了');
      }

      isShowASW = false;
      selectedIndexBox.clear();
      DataManager.storeData();
    });
  }

  /// 数字标识转换成mark
  String indexToMark(int index) {
    return String.fromCharCode(65 + index);
  }

  ///创建选项按钮
  Widget _buildOptionButton(context, int index) {
    return MyOptionWidget(
      text: section.getProblem()!.options[index],
      onPressed: () => setState(() {
        if (selectedIndexBox.contains(index)) {
          selectedIndexBox.remove(index);
        } else {
          selectedIndexBox.add(index);
        }

        // 如果是单选和判断，则用户选择时就提交答案
        if (section.getProblem()!.type != '多选题') {
          submitStream.sink.add(1);
        }
      }),
      color: selectedIndexBox.contains(index) ? Colors.blue[200] : Colors.white,
      mark: indexToMark(index),
    );
  }

  /// 根据选项的状态情况返回按钮的颜色，用于给用户展示正确答案和 错误的选项
  Color? _creatAnserButtonColor(int index) {
    if (problem!.key.contains(String.fromCharCode(index + 65))) {
      return const Color.fromARGB(120, 136, 224, 41);
    }

    if (selectedIndexBox.contains(index) &&
        !problem!.key.contains(_parseSelectedIndex())) {
      return Colors.red;
    }

    return Colors.white;
  }

  ///创建显示答案的按钮
  Widget _buildOptionAswerButton(context, int index) {
    return MyOptionWidget(
      mark: indexToMark(index),
      text: section.getProblem()!.options[index],
      color: _creatAnserButtonColor(index),
      onPressed: () {},
    );
  }

  /// 创建浮动提交答案按钮，用于多选题，如果是单选题和判断题则简化为点击答案出结果
  Widget? _creatfloatingActionButton() {
    Problem? problem = section.getProblem();

    if (problem == null) {
      return null;
    }

    if (problem.type == '多选题') {
      return FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          setState(() {
            submitStream.sink.add(1);
          });
        },
      );
    }

    return null;
  }

  /// 答案选择区
  /// 如果是显示答案模式，那么产生的按钮是不带有反馈的
  Widget _buildSelectView() {
    return ListView.builder(
      itemCount: section.getProblem()!.options.length,
      itemBuilder: isShowASW ? _buildOptionAswerButton : _buildOptionButton,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  /// body的视图
  Widget _buildBodykView() {
    if (section.getProblem() == null) {
      return const Center(child: Text('题目已经做完了！'));
    }

    return ListView(
      children: [
        // 进度信息栏
        InfoBar(subjectIndex, section),

        // 题目显示区域
        _buildQuestionView(),

        const SizedBox(
          height: 20,
        ),
        // 选项区
        _buildSelectView()
      ],
    );
  }

  /// 创建底部导航的第二个是查看题目还是下一题
  BottomNavigationBarItem _buildNextOrCheckItem() {
    if (isShowASW) {
      return const BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward), label: '下一题');
    } else {
      return const BottomNavigationBarItem(
          icon: Icon(Icons.remove_red_eye), label: '查看答案');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(section.name ?? 'Null'),
        centerTitle: true,
      ),
      body: _buildBodykView(),
      floatingActionButton: _creatfloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back), label: '上一题'),
        _buildNextOrCheckItem()
      ], onTap: onNextOrCheckItemTaped),
    );
  }

  void onNextOrCheckItemTaped(int value) {
    setState(
      () {
        if (value == 0) {
          backToPre();
        }

        if (value == 1) {
          if (isShowASW) {
            changeToNext();
          } else {
            showAsw();
          }
        }
      },
    );
  }
}
