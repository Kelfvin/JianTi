import 'package:flutter/material.dart';

import '../../data_class/data_manager.dart';
import '../../config/theme.dart';
import 'subject_card/subject_card_view.dart';
import 'subject_page_logic.dart';
import 'package:get/get.dart';

class SubjectPageView extends StatefulWidget {
  const SubjectPageView({super.key});

  @override
  State<SubjectPageView> createState() => _SubjectPageViewState();
}

class _SubjectPageViewState extends State<SubjectPageView> {
  late SubjectPageLogic logic;

  @override
  Widget build(BuildContext context) {
    logic = Get.put(SubjectPageLogic());

    return Scaffold(
      body: GetBuilder<SubjectPageLogic>(builder: (logic) => _buildBody()),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: MTheme.highLightColor,
      //     child: const Icon(Icons.add),
      //     onPressed: () => logic.onImportTap()),
      backgroundColor: MTheme.baseColor,
    );
  }

  Widget _buildBody() {
    List<Widget> silvers = [];
    silvers.add(SliverAppBar.large(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: ()=>logic.onAboutTap(),
      ),
      title: const Text('简题'),
      actions: [IconButton(onPressed: ()=>logic.onImportTap(), icon: const Icon(Icons.add))],
    ));

    for (int index = 0; index < DataManager.subjects.length; index++) {
      silvers.add(SliverToBoxAdapter(
        child: SubjectCard(
          subjectIndex: index,
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
