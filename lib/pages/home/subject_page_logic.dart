import 'package:get/get.dart';

import '../../dataClass/data_manager.dart';

class SubjectPageLogic extends GetxController {
  void onImportTap() async {
    await DataManager.importFromRom();

    update();
  }
}
