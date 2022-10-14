import 'dart:developer';

import 'package:get/get.dart';

import '../../Dialogue/section/section_dlg.dart';
import '../../dataClass/data_manager.dart';
import '../../dataClass/section.dart';

import '../../dataClass/subject.dart';
import '../../pages/practice_page/practice_page_view.dart';

class SectionCardLogic extends GetxController {
  final int subjectIndex;
  final int sectionIndex;
  late Subject subject;
  late Section section;
  late String name;
  late String progressInfo;

  SectionCardLogic(this.subjectIndex, this.sectionIndex) {
    updateData();
  }

  Future<void> onCardLongTap(context) async {
    await sectionDLG(context, subjectIndex, sectionIndex);
    updateData();
  }

  void updateData() {
    try {
      subject = DataManager.subjects[subjectIndex];
      section = subject.sections[sectionIndex];
      name = section.name ?? 'Null';
      progressInfo = section.getProgressInfo();
    } on RangeError {
      log('删除末尾');
    }

    update();
  }

  Future<void> onPracticeTap() async {
    await Get.to(PracticePageView(
      sectionIndex: sectionIndex,
      subjectIndex: subjectIndex,
    ));

    updateData();
  }
}
