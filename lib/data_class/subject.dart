import 'dart:convert';

import 'package:jian_ti/data_class/fault_book.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:jian_ti/data_class/section.dart';


class Subject {
  String name;
  List<Section> sections;
  FaultBook faultBook;

  Subject(
      {required this.name, required this.sections, required this.faultBook});

  factory Subject.fromMap(Map<String, dynamic> data) => Subject(
      name: (data['name'] as String?)!.trim(),
      sections: (data['sections'] as List<dynamic>)
          .map((e) => Section.fromMap(e as Map<String, dynamic>))
          .toList(),
      faultBook: FaultBook.fromMap(data['faultBook']));

  Map<String, dynamic> toMap() => {
        'name': name,
        'sections': sections.map((e) => e.toMap()).toList(),
        'faultBook': faultBook.toMap()
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Subject].
  factory Subject.fromJson(String data) {
    return Subject.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Subject] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Subject) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => name.hashCode ^ sections.hashCode;

  int getFaultBookLenght() {
    return faultBook.wrongProblems.length;
  }
}
