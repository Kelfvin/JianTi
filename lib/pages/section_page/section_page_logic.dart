import 'package:get/get.dart';

import '../../dataClass/data_manager.dart';
import '../../dataClass/subject.dart';

class SectionPageLogic extends GetxController {
  final int subjectIndex;
  late Subject subject;
  late String subjectName;

  SectionPageLogic(this.subjectIndex) {
    subject = DataManager.subjects[subjectIndex];
    subjectName = subject.name;
  }
}
