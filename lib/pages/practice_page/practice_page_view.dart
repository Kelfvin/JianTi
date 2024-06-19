import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jian_ti/pages/practice_page/practice_page_logic.dart';

import '../../config/theme.dart';

// ignore: must_be_immutable
class PracticePageView extends StatelessWidget {
  PracticePageView(
      {super.key, required this.subjectIndex, required this.sectionIndex});

  int subjectIndex;
  int sectionIndex;

  late PracticePageLogic logic;

  @override
  Widget build(BuildContext context) {
    logic = Get.put<PracticePageLogic>(
        PracticePageLogic(subjectIndex, sectionIndex));
    return GetBuilder<PracticePageLogic>(
        builder: (logic) => Scaffold(
              appBar: AppBar(),
              body: _buildBody(logic),
              backgroundColor: MTheme.baseColor,
              bottomNavigationBar: _buildBottomNavigationBar(),
              floatingActionButton: _buildConfirmFloatButtom(),
            ));
  }

  /// 创建多选题的确定按钮
  FloatingActionButton? _buildConfirmFloatButtom() {
    if (logic.problem == null) {
      return null;
    }

    if (logic.problem!.type != '多选题') {
      return null;
    }
    return FloatingActionButton(
      onPressed: () => logic.checkASW(),
      backgroundColor: MTheme.highLightColor,
      child: const Icon(Icons.check),
    );
  }

  Widget _buildBody(PracticePageLogic logic) {
    if (logic.section.progress >= logic.section.problems!.length) {
      return const Center(
        child: Text('题目已经全部做完了！'),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoBar(),
            _buildProblemTitle(),
            _buildShowASWWidget(logic),
            _buldOptionsView()
          ],
        ),
      );
    }
  }

  Widget _buildShowASWWidget(PracticePageLogic logic) {
    if (logic.isShowKey) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: MTheme.highLightColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Oops!!!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text('你的答案是：${logic.getSelectedResult()}',
                style: const TextStyle(color: Colors.white)),
            Text('正确答案是：${logic.problem?.key ?? 'Null'},已经为您加入错题本！',
                style: const TextStyle(color: Colors.white)),
            Text('参考解析是：${logic.problem?.hint ?? '没有提示！'}',
                style: const TextStyle(color: Colors.white))
          ]),
        ),
      );
    } else {
      return Container();
    }
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) => logic.onBottomNavigationTap(value),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: '后退'),
        BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded), label: '全局'),
        BottomNavigationBarItem(icon: Icon(Icons.remove_red_eye), label: '答案'),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward),
          label: '前进',
        ),
      ],
      backgroundColor: MTheme.baseColor,
      type: BottomNavigationBarType.fixed,
    );
  }

  Card _buildProblemTitle() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: MTheme.titleBackGroundColor,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  logic.section.getProblem()?.title ?? '',
                  style: const TextStyle(fontSize: 20),
                  maxLines: 999,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildInfoBar() {
    return Row(
      children: [
        buildChip(logic.subject.name),
        buildChip(logic.section.name ?? 'Null'),
        buildChip(
            '${logic.section.progress}/${logic.section.problems?.length}'),
        buildChip(logic.problem?.type ?? 'Null')
      ],
    );
  }

  Widget buildChip(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ActionChip(
        label: Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
        onPressed: () {},
        backgroundColor: MTheme.middleColor,
      ),
    );
  }

  /// 创建整个选项区
  Widget _buldOptionsView() {
    List<Widget> options = [];
    for (int i = 0; i < logic.section.getProblem()!.options.length; i++) {
      Widget option = _buildOptionWidget(i);
      options.add(option);
    }

    return Column(
      children: options,
    );
  }

  /// 创建单个选项的组件
  Widget _buildOptionWidget(int index) {
    Color bottumColor = logic.selectedIndexList.contains(index)
        ? MTheme.middleColor
        : Colors.white;

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: InkWell(
        onTap: () => logic.onOptionTap(index),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: bottumColor, borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  String.fromCharCode(index + 65),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(
                logic.problem?.options[index] ?? 'Null',
                style: const TextStyle(fontSize: 15),
                maxLines: 999,
              ),
            )
          ],
        ),
      ),
    );
  }
}
