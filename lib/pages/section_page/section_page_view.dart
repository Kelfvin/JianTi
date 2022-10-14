import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/theme.dart';
import '../../widget/section_card/section_card_view.dart';
import 'section_page_logic.dart';

// ignore: must_be_immutable
class SectionPageView extends StatelessWidget {
  final int subjectIndex;
  late SectionPageLogic logic;
  SectionPageView({super.key, required this.subjectIndex});

  @override
  Widget build(BuildContext context) {
    logic = Get.put(SectionPageLogic(subjectIndex));

    return Scaffold(
      body: GetBuilder<SectionPageLogic>(builder: (logic) => _buildBody()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MTheme.highLightColor,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      backgroundColor: MTheme.baseColor,
    );
  }

  Widget _buildBody() {
    List<Widget> silvers = [];
    silvers.add(SliverAppBar.large(
      title: Text(logic.subjectName),
    ));

    for (int index = 0; index < logic.subject.sections.length; index++) {
      silvers.add(SliverToBoxAdapter(
        child: SectionCard(
          subjectIndex: subjectIndex,
          sectionIndex: index,
        ),
      ));
    }

    return Container(
      color: MTheme.baseColor,
      child: CustomScrollView(
        slivers: silvers,
      ),
    );
  }
}
