import 'package:get/get.dart';

import '../../data_class/data_manager.dart';
import '../../data_class/subject.dart';

class SectionPageLogic extends GetxController {
  final int subjectIndex;
  late Subject subject;
  late String subjectName;

  SectionPageLogic(this.subjectIndex) {
    subject = DataManager.subjects[subjectIndex];
    subjectName = subject.name;
  }
}
