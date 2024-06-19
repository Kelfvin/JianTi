import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data_class/data_manager.dart';
import '../../data_class/problem.dart';
import '../../data_class/section.dart';
import '../../data_class/subject.dart';

class PracticePageLogic extends GetxController {
  List<int> selectedIndexList = [];
  late Subject subject;
  late Section section;
  Problem? problem;
  bool isShowKey = false;

  /// 如果sectionIndex 为负数表示错题本
  PracticePageLogic(int subjectIndex, int sectionIndex) {
    subject = DataManager.subjects[subjectIndex];

    if (sectionIndex < 0) {
      section = subject.faultBook.toSection(subjectIndex);
    } else {
      section = subject.sections[sectionIndex];
    }
    problem = section.getProblem();
  }

  /// 0 后退
  /// 1全局查看
  /// 2答案
  /// 3前进
  void onBottomNavigationTap(int index) {
    if (index == 0) {
      backPre();
    } else if (index == 1) {
      // 全局查看 功能没做
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          height: Get.height * 0.618,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, // 每行个数
              childAspectRatio: 1.0, // 宽高比为 1，使其成为正方形
            ),
            itemCount: section.problems!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(6.0), // 添加一些间隔
                decoration: BoxDecoration(
                  color: Colors.green, // 背景
                  // todo 全局背景色
                  // 白色 未做
                  // 绿色 做对
                  // 红色 做错
                  borderRadius: BorderRadius.circular(10.0), // 圆角的大小
                  shape: BoxShape.rectangle, // 方形
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white), // 白色文字
                  ),
                ),
              );
            },
          ),
        ),
        isScrollControlled: true,
      );
    } else if (index == 2) {
      showASW();
      subject.faultBook.addWrongQuestion(problem);
    } else {
      changeToNext();
    }
  }

  void showASW() {
    if (isShowKey) {
      return;
    }

    isShowKey = true;
    update();
  }

  /// 添加或者删除选择，如果有就删除，如果没有就加入
  /// 如果状态是显示错题，那么禁用页面更新
  void onOptionTap(int index) {
    if (isShowKey) {
      return;
    }

    if (problem!.type == '多选题') {
      if (selectedIndexList.contains(index)) {
        selectedIndexList.remove(index);
      } else {
        selectedIndexList.add(index);
        selectedIndexList.sort();
      }

      update();
    } else {
      selectedIndexList.add(index);
      checkASW();
    }
  }

  void checkASW() {
    if (getSelectedResult() == problem?.key) {
      subject.faultBook.wellDoneProblem(problem);
      changeToNext();
    } else {
      subject.faultBook.addWrongQuestion(problem);
      isShowKey = true;
      update();
    }
  }

  void changeToNext() {
    if (section.progress < section.problems!.length) {
      section.progress++;
      problem = section.getProblem();
      selectedIndexList.clear();
      isShowKey = false;
      DataManager.storeData();
      update();
    }
  }

  /// 返回上一道题目
  void backPre() {
    if (section.progress > 0) {
      section.progress--;
      problem = section.getProblem();
      selectedIndexList.clear();
      isShowKey = false;
      DataManager.storeData();
      update();
    }
  }

  /// 返回用户选择 Index 对应的 ABCD 结果
  String getSelectedResult() {
    String result = '';

    for (var index in selectedIndexList) {
      result += String.fromCharCode(index + 65);
    }

    return result;
  }
}
