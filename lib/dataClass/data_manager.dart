import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';

import '../pages/home/subject_page_logic.dart';
import 'subject.dart';

import 'package:get/get.dart';

/// SharePreferenceTool 工具
abstract class SharePreferenceTool {
  static late SharedPreferences _sp;
  static bool _inited = false;

  static SharedPreferences get sp => _sp;

  static bool get inited => _inited;

  static Future<bool> init() async {
    _sp = await SharedPreferences.getInstance();
    _inited = true;
    return true;
  }
}

/// 负责题库数据的管理
class DataManager {
  /// 全局题目
  static List<Subject> subjects = [];
  static var dataStream = StreamController();

  static void cleanSubjectFaultBook(int subjectIndex) {
    subjects[subjectIndex].faultBook.wrongProblems.clear();
    storeData();
    dataStream.sink.add(1);
  }

  /// 移除科目
  static void deleteSubject(int subjectIndex) {
    subjects.removeAt(subjectIndex);
    storeData();
    dataStream.sink.add(1);
  }

  /// 移除章节
  static void deleteSection(int subjectIndex, int sectionIndex) {
    subjects[subjectIndex].sections.removeAt(sectionIndex);
    storeData();
    dataStream.sink.add(1);
  }

  /// 清除章节的做题记录
  static void cleanSectionProgress(int subjectIndex, int sectionIndex) {
    subjects[subjectIndex].sections[sectionIndex].progress = 0;
    DataManager.dataStream.sink.add(1);
    DataManager.storeData();
    dataStream.sink.add(1);
  }

  /// 清除科目的做题记录
  static void cleanSubjectProgress(int subjectIndex) {
    for (var section in subjects[subjectIndex].sections) {
      section.progress = 0;
    }

    DataManager.storeData();
    dataStream.sink.add(1);
  }

  /// 加载数据
  static Future<bool> loadData() async {
    if (!SharePreferenceTool.inited) {
      await SharePreferenceTool.init();
    }

    List<String>? strList = SharePreferenceTool.sp.getStringList('subjects');

    // 用于 题库出现bug时还原
    // await _forTheFirstTime();

    // 程序的第一次启动
    if (strList == null) {
      await _forTheFirstTime();
    }
    // 之后程序启动
    else {
      for (var jsonStr in strList) {
        var subject = Subject.fromJson(jsonStr);
        subjects.add(subject);
      }
    }

  Get.find<SubjectPageLogic>().update();

    return true;
  }

  static Future<bool> storeData() async {
    if (!SharePreferenceTool.inited) {
      await SharePreferenceTool.init();
    }

    List<String> strList = [];
    for (var subject in subjects) {
      strList.add(subject.toJson());
    }

    SharePreferenceTool.sp.setStringList('subjects', strList);

    return true;
  }

  /// 若第一次启动，将asset的题库放置到应用数据文件夹，做好初始化
  static Future<bool> _forTheFirstTime() async {
    var manifestContent = await rootBundle.loadString('AssetManifest.json');

    Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final filePaths = manifestMap.keys
        .where((String key) => key.contains('bank/'))
        .where((String key) => key.contains('.json'))
        .toList();

    List<String> stringList = [];

    for (var filePath in filePaths) {
      String jsonStr = await rootBundle.loadString(filePath);
      stringList.add(jsonStr);

      var subject = Subject.fromJson(jsonStr);
      subjects.add(subject);
    }

    SharePreferenceTool.sp.setStringList('subjects', stringList);
    return true;
  }

  /// 统计指定科目的总的做题进度
  static int getSubjectProgress(int index) {
    int totalProgress = 0;
    for (var element in subjects[index].sections) {
      totalProgress += element.progress;
    }

    return totalProgress;
  }

  static int getSubjectProblemCount(int index) {
    int count = 0;

    for (var element in subjects[index].sections) {
      count += element.problems!.length;
    }
    return count;
  }

  /// 返回一个科目的总进度
  static String getProgressStr(int index) {
    return '${getSubjectProgress(index)}/${getSubjectProblemCount(index)}';
  }

  /// 从外部导入题库
  static Future<bool> importFromRom() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);

        String jsonStr = await file.readAsString();

        var subject = Subject.fromJson(jsonStr);

        subjects.add(subject);
        DataManager.storeData();
        dataStream.sink.add(1);
        // showToast('导入成功！');
        return true;
      } else {
        // User canceled the picker
        // showToast('取消导入！');
        return false;
      }
    } catch (e) {
      // showToast('题库格式错误！');
      return false;
    }
  }
}
