import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class Problem {
  final String title;
  final String key;
  final String type;
  final List<String> options;

  // 用于错题本里面的错题，普通题目无意义
  int neededDoneTime;

  Problem(
      {required this.title,
      required this.key,
      required this.type,
      required this.options,
      this.neededDoneTime = 0
      });

  static String standarlizeTitle(Map<String, dynamic> data) {
    return data['title'].trim();
  }

  static String standarlizeKey(Map<String, dynamic> data) {
    // 规范化答案
    var key = data['key'];
    key.toUpperCase();
    List<String> charList = [];
    for (int i = 0; i < key.length; i++) {
      charList.add(key[i]);
    }
    charList.sort();

    key = '';
    for (var element in charList) {
      key += element;
    }

    return key;
  }

  static List<String> standarlizeOptions(Map<String, dynamic> data) {
    List<String> options = data['options'].cast<String>();
    for (var element in options) {
      element = element.trim();
    }

    return options;
  }

  static String standarlizeType(Map<String, dynamic> data) {
    String type = data['type'];
    return type.trim();
  }

  factory Problem.fromMap(Map<String, dynamic> data) {
    var problem = Problem(
      title: standarlizeTitle(data),
      key: standarlizeKey(data),
      type: standarlizeType(data),
      options: standarlizeOptions(data),
      neededDoneTime: data['neededDoneTime']??0
    );

    return problem;
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'key': key,
        'type': type,
        'options': options,
        'neededDoneTime':neededDoneTime
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Problem].
  factory Problem.fromJson(String data) {
    return Problem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Problem] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Problem) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      title.hashCode ^ key.hashCode ^ type.hashCode ^ options.hashCode;
}
