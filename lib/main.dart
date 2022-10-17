import 'dart:io';

import 'package:jian_ti/pages/privacy_page.dart';
import 'package:jian_ti/pages/subject_page/subject_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'main_logic.dart';

void main() {
  runApp(const MyApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MainLogic logic;

  @override
  void initState() {
    logic = Get.put<MainLogic>(MainLogic());
    logic.checkUsrAcceptPrivacy();

    super.initState();
  }

  // Widget _buildBottomNavigator() {
  //   return BottomNavigationBar(
  //       items: [
  //         BottomNavigationBarItem(icon: Icon(Icons.edit), label: '做题'),
  //         BottomNavigationBarItem(icon: Icon(Icons.book), label: '题库'),
  //         BottomNavigationBarItem(icon: Icon(Icons.settings), label: '设置'),
  //       ],
  //       currentIndex: pageSlectedIndex,
  //       selectedItemColor: Colors.amber[200],
  //       onTap: ((value) => setState(() {
  //             pageSlectedIndex = value;
  //           })));
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '简题',
      theme: ThemeData(primarySwatch: Colors.brown, useMaterial3: true),
      home: GetBuilder<MainLogic>(builder: (logic) => _buildHome()),
      // _buildView(),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildHome() {
    // return PrivacyPage();

    return logic.isAcceptPrivacy
        ? const SubjectPageView()
        : PrivacyPage();
  }
}
