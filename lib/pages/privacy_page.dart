import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../common/assets_manage.dart';
import '../config/theme.dart';
import '../data_class/data_manager.dart';
import '../main_logic.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPage extends StatefulWidget {
  PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  /// 用户协议
  late TapGestureRecognizer _termsAndConditionRecognizer;

  /// 隐私政策
  late TapGestureRecognizer _privacyPolicyRecognizer;

  @override
  void initState() {
    super.initState();

    _termsAndConditionRecognizer = TapGestureRecognizer();

    _privacyPolicyRecognizer = TapGestureRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsManager.startImage),
                fit: BoxFit.cover)),
        child: _buildInfoView(context),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildInfoView(contex) {
    return Stack(children: [
      Positioned(
        left: 15,
        bottom: 50,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            '简题',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const Text('by kelf'),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: RichText(
              softWrap: true,
              maxLines: 999,
              text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    const TextSpan(text: '根据相关法律法规要求，我们更新完善了'),
                    TextSpan(
                        text: '《用户协议》',
                        style: TextStyle(color: MTheme.middleColor),
                        recognizer: _termsAndConditionRecognizer
                          ..onTap = () {
                            launch(
                                'https://www.wolai.com/pDbAhonZZvNgR9Ferubkd7');
                          }),
                    const TextSpan(text: '与'),
                    TextSpan(
                        text: '《隐私政策》',
                        style: TextStyle(color: MTheme.middleColor),
                        recognizer: _privacyPolicyRecognizer
                          ..onTap = () {
                            launch(
                                'https://www.wolai.com/6RQaqtKMFu3i9r8cfBWxPK');
                          }),
                    const TextSpan(text: '。进入app前请自行阅读，如果您不同意该协议，您将无法使用本app'),
                  ]),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Image.asset(
            AssetsManager.logoImage,
            height: 100,
            width: 100,
          )
        ]),
      ),
    ]);
  }

  Stack _buildFloatingActionButton() {
    return Stack(
      children: [
        Positioned(
          bottom: 30,
          right: 0,
          child: Column(
            children: [
              FloatingActionButton.extended(
                backgroundColor: MTheme.highLightColor,
                icon: const Icon(Icons.exit_to_app),
                onPressed: () => exit(0),
                label: const Text('取消'),
              ),
              const SizedBox(
                height: 5,
              ),
              FloatingActionButton.extended(
                icon: const Icon(Icons.check),
                onPressed: _onAcceptPrivacy,
                label: const Text('确定'),
                backgroundColor: MTheme.highLightColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onAcceptPrivacy() async {
    if (!SharePreferenceTool.inited) {
      await SharePreferenceTool.init();
    }

    SharePreferenceTool.sp.setBool('Accept_Privacy', true);

    MainLogic logic = Get.find<MainLogic>();

    logic.checkUsrAcceptPrivacy();
  }
}
