import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/assets_manage.dart';
import '../../config/theme.dart';
import 'about_page_card.dart';
import 'package:get/get.dart';
import 'about_page_logic.dart';

// ignore: must_be_immutable
class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);
  late AboutPageLogic logic;

  @override
  Widget build(BuildContext context) {
    logic = Get.put(AboutPageLogic());
    logic.getAPPVersion();

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('About 简题'),
        ),
        _buildVersionCard(),
        _buildAboutBankCard(),
        _buildDonateCard()
      ],
    ));
  }

  Widget _buildDonateCard() {
    return SliverToBoxAdapter(
      child: AboutPageCard(imageUrl: AssetsManager.donateCardImage, children: [
        const Text(
          '支持我',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        const Text(
          '制作不易，如果你觉得有帮助的话可以请我喝一杯Java。',
          maxLines: 999,
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: [
            ActionChip(
                backgroundColor: MTheme.highLightColor,
                onPressed: () =>
                    launch('https://www.wolai.com/7rhsZrQW12sBC1aqASxhzQ'),
                label: Row(
                  children: const [
                    // Image.asset(
                    //   AssetsManager.githubLogo,
                    //   height: 20,
                    // ),
                    Text('前往支持')
                  ],
                )),
          ],
        ),
        const SizedBox(height: 10)
      ]),
    );
  }

  SliverToBoxAdapter _buildAboutBankCard() {
    return SliverToBoxAdapter(
        child: AboutPageCard(
            imageUrl: AssetsManager.aboutBankCardIamge,
            children: [
          const Text(
            '开源和题库定制',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          const Text(
            '代码开放在 Github 和 Gitee 上欢迎指点。题库的定制方法也在网站上',
            maxLines: 999,
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              ActionChip(
                  backgroundColor: MTheme.highLightColor,
                  onPressed: () => launch('https://github.com/Kelfvin/JianTi'),
                  label: Row(
                    children: const [
                      // Image.asset(
                      //   AssetsManager.githubLogo,
                      //   height: 20,
                      // ),
                      Text('GitHub仓库')
                    ],
                  )),
              const SizedBox(
                width: 10,
              ),
              ActionChip(
                  backgroundColor: MTheme.highLightColor,
                  onPressed: () =>
                      launch('https://www.wolai.com/avRdgjLxxQ5eLbMabKiMAh'),
                  label: Row(
                    children: const [
                      // Image.asset(
                      //   AssetsManager.githubLogo,
                      //   height: 20,
                      // ),
                      Text('帮助文档')
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 10)
        ]));
  }

  Widget _buildVersionCard() {
    return GetBuilder<AboutPageLogic>(builder: (logic) {
      return SliverToBoxAdapter(
        child:
            AboutPageCard(imageUrl: AssetsManager.versionCardImage, children: [
          const Text(
            '简题-版本',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          Text(
            'Version ${logic.version}',
            style: const TextStyle(color: Colors.white),
          ),
          const Text('希望这个APP可以帮助到大家', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 10)
        ]),
      );
    });
  }
}
