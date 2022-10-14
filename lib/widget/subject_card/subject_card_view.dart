import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jian_ti/widget/subject_card/subject_card_logic.dart';

// ignore: must_be_immutable
class SubjectCard extends StatelessWidget {
  final int subjectIndex;

  late SubjectCardLogic logic;

  SubjectCard({super.key, required this.subjectIndex});

  @override
  Widget build(BuildContext context) {
    logic = Get.put<SubjectCardLogic>(
        tag: 'subject$subjectIndex', SubjectCardLogic(subjectIndex));
    logic.updateData();
    return GetBuilder<SubjectCardLogic>(
        tag: 'subject$subjectIndex',
        builder: (logic) => Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: const Color(0xFF8C9F6D),
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(30))),
              child: InkWell(
                  onLongPress: () => logic.onCardLongTap(context),
                  child: Column(
                    children: [
                      subjectInfo(),
                      subjectBar(),
                    ],
                  )),
            ));
  }

  Row subjectBar() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 16, 10),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF506F38))),
            onPressed: () => logic.onPracticeTap(),
            child: const Text(
              '章节',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => logic.onFaultBookReviewTap(),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF506F38))),
            child: const Text(
              '错题',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Row subjectInfo() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: Text(
            logic.name,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: subjectProgress(),
        )
      ],
    );
  }

  Column subjectProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '进度：${logic.progressInfo}',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          '错题：${logic.faultbookNum}道',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        )
      ],
    );
  }
}
