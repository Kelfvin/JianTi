import 'package:get/get.dart';

import '../../data_class/data_manager.dart';
import '../about/about_page.dart';

class SubjectPageLogic extends GetxController {
  void onImportTap() async {
    await DataManager.importFromRom();

    update();
  }

  void onAboutTap() {
    Get.to(AboutPage());
  }
}
