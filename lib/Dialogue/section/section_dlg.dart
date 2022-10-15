import 'package:jian_ti/dialogue/section/clean_section_progress_dlg.dart';
import 'package:jian_ti/dialogue/section/delete_section_dlg.dart';
import 'package:jian_ti/data_class/data_manager.dart';
import 'package:flutter/material.dart';

Future <void> sectionDLG(context, int subjectIndex, int sectionIndex) async {
  var subject = DataManager.subjects[subjectIndex];
  var section = subject.sections[sectionIndex];
  int? selectedIndex = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('${subject.name}->${section.name}'),
          children: [
            SimpleDialogOption(
              child: const Text('删除章节'),
              onPressed: () => Navigator.pop(context, 1),
            ),
            SimpleDialogOption(
              child: const Text('清除做题进度'),
              onPressed: () => Navigator.pop(context, 2),
            ),
          ],
        );
      });

  switch (selectedIndex) {
    case 1:
      await deleteSectionDLG(context, subjectIndex, sectionIndex);
      break;

    case 2:
      await cleanSectionProgressDLG(context, subjectIndex, sectionIndex);
      break;
  }
}
