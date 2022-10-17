import 'package:get/get.dart';

import 'data_class/data_manager.dart';

class MainLogic extends GetxController {
  bool isAcceptPrivacy = false;

  Future<void> checkUsrAcceptPrivacy() async {
    if (!SharePreferenceTool.inited) {
      await SharePreferenceTool.init();
    }

    // 检测用户是否接受隐私政策
    bool? acceptPrivacy = SharePreferenceTool.sp.getBool('Accept_Privacy');

    if (acceptPrivacy == null) {
      isAcceptPrivacy = false;
    } 
    else {
      isAcceptPrivacy = acceptPrivacy;
    }

    update();
  }
}
