import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'problem.dart';

class Section {
  String? name;
  int progress = 0;
  List<Problem>? problems;

  Section({this.name, required this.progress, this.problems});

  Problem? getProblem() {
    if (progress < problems!.length) {
      return problems![progress];
    } else {
      return null;
    }
  }

  factory Section.fromMap(Map<String, dynamic> data) => Section(
        name: data['name'] as String?,
        progress: data['progress'] as int,
        problems: (data['problems'] as List<dynamic>?)
            ?.map((e) => Problem.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'progress': progress,
        'problems': problems?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Section].
  factory Section.fromJson(String data) {
    return Section.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Section] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Section) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => name.hashCode ^ progress.hashCode ^ problems.hashCode;

  String getProgressInfo() {
    return '$progress/${problems!.length}';
  }
}
