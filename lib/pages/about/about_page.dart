import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/assets_manage.dart';
import '../../config/theme.dart';
import 'aboutPageCard.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return const SliverToBoxAdapter(
      child: AboutPageCard(
          imageUrl:
              'https://images.unsplash.com/photo-1541167760496-1628856ab772?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2074&q=80',
          children: [
            Text(
              '支持我',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Text(
              '制作不易，如果你觉得有帮助的话可以请我喝一杯Java。',
              maxLines: 999,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10)
          ]),
    );
  }

  SliverToBoxAdapter _buildAboutBankCard() {
    return SliverToBoxAdapter(
        child: AboutPageCard(
            imageUrl:
                'https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
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
                  onPressed: () => launch('https://www.baidu.com'),
                  label: Row(
                    children: [
                      Image.asset(
                        AssetsManager.githubLogo,
                        height: 20,
                      ),
                      const Text('Json题库')
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 10)
        ]));
  }

  SliverToBoxAdapter _buildVersionCard() {
    return const SliverToBoxAdapter(
      child: AboutPageCard(
          imageUrl:
              'https://images.unsplash.com/photo-1483794344563-d27a8d18014e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
          children: [
            Text(
              '简题-版本',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Text(
              'Version 0.0.1',
              style: TextStyle(color: Colors.white),
            ),
            Text('希望这个APP可以帮助到大家', style: TextStyle(color: Colors.white)),
            SizedBox(height: 10)
          ]),
    );
  }
}
