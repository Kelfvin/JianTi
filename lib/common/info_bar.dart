import 'package:jian_ti/dataClass/data_manager.dart';
import 'package:jian_ti/dataClass/problem.dart';
import 'package:jian_ti/dataClass/section.dart';
import 'package:flutter/material.dart';

import '../dataClass/subject.dart';

// ignore: must_be_immutable
class InfoBar extends StatelessWidget {
  int subjectIndex;
  Section section;

  InfoBar(this.subjectIndex, this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String type;

    Problem? problem = section.getProblem();
    if (problem == null) {
      return Container();
    }

    type = problem.type;

    int progress = section.progress;
    int quantity = section.problems!.length;

    Subject subject = DataManager.subjects[subjectIndex];

    Problem? problemInFaultBook = subject.faultBook.findProblem(problem);
    int needDoneTime;
    if (problemInFaultBook == null) {
      needDoneTime = 1;
    } else {
      needDoneTime = problemInFaultBook.neededDoneTime;
    }

    return Container(
      color: Colors.blue[100],
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.green),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Text(type),
            ),
            Expanded(
              flex: 1,
              child: Text('$progress/$quantity'),
            ),
            Expanded(flex: 1, child: Text('$needDoneTime'))
          ],
        ),
      ),
    );
  }
}
