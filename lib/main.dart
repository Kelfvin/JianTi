import 'dart:io';

import 'package:jian_ti/data_class/data_manager.dart';
import 'package:jian_ti/pages/subject_page/subject_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
  @override
  void initState() {
    ///初始化题库
    _initData();
    super.initState();
  }

  void _initData() async {
    await DataManager.loadData();
    setState(() {});
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
      home: const SubjectPageView(),
      // _buildView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
