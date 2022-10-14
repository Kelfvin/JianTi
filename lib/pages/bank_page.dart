import 'package:jian_ti/Dialogue/section/section_dlg.dart';
import 'package:jian_ti/Dialogue/subject/subject_dlg.dart';
import 'package:jian_ti/dataClass/data_manager.dart';
import 'package:jian_ti/common/my_toast.dart';
import 'package:jian_ti/pages/practice_page/practice_page_view.dart';
import 'package:flutter/material.dart';

class BankPage extends StatefulWidget {
  const BankPage({Key? key}) : super(key: key);

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  late MyToast myToast;

  int? expandSubjectIndex;

  @override
  void initState() {
    super.initState();
  }

  void _refresh() async {
    setState(() {});
  }

  /// 构建章节 widget
  Widget _buildSectionWidget(int subjectIndex, int sectionIndex) {
    var section = DataManager.subjects[subjectIndex].sections[sectionIndex];
    return InkWell(
      onTap: (() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PracticePageView(
            subjectIndex: subjectIndex,
            sectionIndex: sectionIndex,
          );
        })).then((value) {
          _refresh();
        });
      }),
      onLongPress: () => sectionDLG(context, subjectIndex, sectionIndex),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 8, 8, 8),
        child: Text(
          '${section.name!}  (${section.progress}/${section.problems!.length})',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  /// 构建章节 widget List
  List<Widget> _buildSubViewList(int subjectIndex) {
    List<Widget> subList = [];
    var subject = DataManager.subjects[subjectIndex];
    for (int sectionIndex = 0;
        sectionIndex < subject.sections.length;
        sectionIndex++) {
      subList.add(_buildSectionWidget(subjectIndex, sectionIndex));
    }
    return subList;
  }

  /// 科目
  Widget _buildItemView(context, int subjectIndex) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: ExpansionTile(
        title: GestureDetector(
          onLongPress: () => subjectDLG(context, subjectIndex),
          child: Text(
            '${DataManager.subjects[subjectIndex].name} ${DataManager.getProgressStr(subjectIndex)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        expandedAlignment: Alignment.centerLeft,
        children: _buildSubViewList(subjectIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.medium(
          title: const Text('题库'),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _buildItemView(context, index),
                childCount: DataManager.subjects.length))
      ],
    );
  }
}
