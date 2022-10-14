
import 'package:jian_ti/common/assets_manage.dart';
import 'package:jian_ti/common/my_toast.dart';
import 'package:jian_ti/pages/about/about_page.dart';
import 'package:jian_ti/pages/fault_book_page.dart';
import 'package:flutter/material.dart';

import '../dataClass/data_manager.dart';
import 'bank_page.dart';
import 'setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  /// 用于切换题库页面和错题页面
  int pageIndex = 0;
  List<String> pageName = ['主页', '错题本'];
  late MyToast myToast;

  @override
  void initState() {
    pageController = PageController(initialPage: pageIndex);

    /// 监听题库的变化
    /// 1 表示题库发生变化
    DataManager.dataStream.stream.listen((event) {
      if (event == 1) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: pageController,
          onPageChanged: ((value) {
            setState(() {
              pageIndex = value;
            });
          }),
          children: const [BankPage(), FaultBookPage()],
        ),
      // bottomNavigationBar: _buildBottomNavigator(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            DataManager.importFromRom().then((value) {
              setState(() {});
            });
          }),

      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        AssetsManager.drawImage,
                      ),
                      fit: BoxFit.cover)),
              child: Container(),
            ),
            ListTile(
              title: const Text('设置'),
              leading: const Icon(Icons.settings),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SettingPage();
              })),
            ),
            ListTile(
              title: const Text('关于'),
              leading: const Icon(Icons.info),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AboutPage();
              })),
            )
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '错题',
          ),
        ],
        onTap: (value) {
          pageController.animateToPage(value,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        currentIndex: pageIndex,
      ),
    );
  }
}
