import 'package:jian_ti/dataClass/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/home/subject_page_logic.dart';

Future<void> deleteSubjectDLG(context, int subjectIndex) async {
  bool? result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(DataManager.subjects[subjectIndex].name),
            content: const Text('你确定要删除吗？（该操作不可撤销！）'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('取消')),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('删除'))
            ],
          ));

  if (result ?? false) {
    DataManager.deleteSubject(subjectIndex);
    var logic = Get.find<SubjectPageLogic>();
    logic.update();
  }
}
