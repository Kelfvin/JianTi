import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPageLogic extends GetxController {
  late String version = 'x.x.x';

  Future<void> getAPPVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;

    update();
  }
}
