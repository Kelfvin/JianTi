import 'package:jian_ti/dialogue/subject/clean_subject_fault_book_dlg.dart';
import 'package:jian_ti/dialogue/subject/clean_subject_progress_dlg.dart';
import 'package:jian_ti/dialogue/subject/delete_subject_dlg.dart';
import 'package:flutter/material.dart';

import '../../data_class/data_manager.dart';

Future<void> subjectDLG(context, int subjectIndex) async {
  var subject = DataManager.subjects[subjectIndex];
  int? selectedIndex = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(subject.name),
          children: [
            SimpleDialogOption(
              child: const Text('删除科目'),
              onPressed: () => Navigator.pop(context, 1),
            ),
            SimpleDialogOption(
              child: const Text('清除做题进度'),
              onPressed: () => Navigator.pop(context, 2),
            ),
            SimpleDialogOption(
              child: const Text('清空错题本'),
              onPressed: () => Navigator.pop(context, 3),
            )
          ],
        );
      });

  switch (selectedIndex) {
    case 1:
      await deleteSubjectDLG(context, subjectIndex);
      break;
    case 2:
      await cleanSubjectProgressDLG(context, subjectIndex);
      break;
    case 3:
      await cleanSubjectFaultBookDLG(context, subjectIndex);
      break;
  }

}
