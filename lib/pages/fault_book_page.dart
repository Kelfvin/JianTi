import 'package:jian_ti/dataClass/section.dart';
import 'package:jian_ti/pages/practice_page.dart';
import 'package:flutter/material.dart';

import '../Dialogue/subject/subject_dlg.dart';
import '../dataClass/data_manager.dart';

class FaultBookPage extends StatelessWidget {
  const FaultBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: DataManager.subjects.length, itemBuilder: _buildItemView);
  }

  Widget _buildItemView(context, int subjectIndex) {
    return InkWell(
      onTap: () {
        Section section = Section(progress: 0);
        section.problems =
            DataManager.subjects[subjectIndex].faultBook.wrongProblems;
        section.problems!.shuffle();
        section.name = '${DataManager.subjects[subjectIndex].name}错题';
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PracticePage(subjectIndex, section);
        }));
      },
      onLongPress: () => subjectDLG(context, subjectIndex),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
        padding: const EdgeInsets.all(11.5),
        child: Text(
          '${DataManager.subjects[subjectIndex].name} ${DataManager.subjects[subjectIndex].faultBook.wrongProblems.length}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
