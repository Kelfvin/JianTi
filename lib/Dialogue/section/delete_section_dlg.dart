import 'package:jian_ti/data_class/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/section_page/section_page_logic.dart';

Future<void> deleteSectionDLG(
    context, int subjectIndex, int sectionIndex) async {
  bool? result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
                '${DataManager.subjects[subjectIndex].name}-> ${DataManager.subjects[subjectIndex].sections[sectionIndex].name}'),
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
    DataManager.deleteSection(subjectIndex, sectionIndex);
    Get.find<SectionPageLogic>().update();
  }
}
