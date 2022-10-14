import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../config/theme.dart';

class AboutPageCard extends StatelessWidget {
  final String imageUrl;
  final List<Widget> children;

  const AboutPageCard(
      {super.key, required this.children, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // color: MTheme.middleColor,
      clipBehavior: Clip.antiAlias,
      color: MTheme.middleColor,
      child: InkWell(
        onLongPress: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 30, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
