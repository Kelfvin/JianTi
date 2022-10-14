import 'package:get/get.dart';

import '../../dataClass/data_manager.dart';
import '../../dataClass/problem.dart';
import '../../dataClass/section.dart';
import '../../dataClass/subject.dart';

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
