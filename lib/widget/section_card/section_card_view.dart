import 'package:flutter/material.dart';
import 'section_card_logic.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SectionCard extends StatelessWidget {
  final int subjectIndex;
  final int sectionIndex;

  late SectionCardLogic logic;

  SectionCard(
      {super.key, required this.subjectIndex, required this.sectionIndex});

  @override
  Widget build(BuildContext context) {
    logic = Get.put<SectionCardLogic>(
        tag: 'subject${subjectIndex}section$sectionIndex',
        SectionCardLogic(subjectIndex, sectionIndex));
    logic.updateData();
    return GetBuilder<SectionCardLogic>(
        tag: 'subject${subjectIndex}section$sectionIndex',
        builder: (logic) {
          return Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: const Color(0xFF8C9F6D),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(30))),
            child: InkWell(
                onLongPress: () => logic.onCardLongTap(context),
                child: Column(
                  children: [
                    sectionInfo(),
                    sectionBar(),
                  ],
                )),
          );
        });
  }

  Row sectionBar() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 16, 16, 16),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF506F38))),
            onPressed: () => logic.onPracticeTap(),
            child: const Text(
              '开始练习',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Row sectionInfo() {
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: sectionProgress(),
        )
      ],
    );
  }

  Column sectionProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '进度：${logic.progressInfo}',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
