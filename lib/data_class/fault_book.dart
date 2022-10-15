import 'package:jian_ti/data_class/data_manager.dart';
import 'package:jian_ti/data_class/problem.dart';
import 'package:jian_ti/data_class/section.dart';

class FaultBook {
  List<Problem> wrongProblems;

  FaultBook({this.wrongProblems = const []});

  factory FaultBook.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return FaultBook(wrongProblems: []);
    }

    List<dynamic> mlist = data['problems'] ?? [];

    return FaultBook(
      wrongProblems: (mlist)
          .map((e) => Problem.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'problems': wrongProblems.map((e) => e.toMap()).toList()};
  }

  void wellDoneProblem(Problem? problem) {
    if (problem == null) return;
    for (int index = 0; index < wrongProblems.length; index++) {
      if (problem.title == wrongProblems[index].title) {
        wrongProblems[index].neededDoneTime--;
        if (wrongProblems[index].neededDoneTime <= 0) {
          wrongProblems.removeAt(index);
        }
        DataManager.storeData();
      }
    }
  }

  void addWrongQuestion(Problem? problem) {
    if (problem == null) return;
    Problem? alreadyAddedProblem = findProblem(problem);
    if (alreadyAddedProblem == null) {
      problem.neededDoneTime = 3;
      wrongProblems.add(problem);
    } else {
      alreadyAddedProblem.neededDoneTime = 3;
    }

    DataManager.storeData();
  }

  Problem? findProblem(Problem problem) {
    for (var element in wrongProblems) {
      if (element.title == problem.title) {
        return element;
      }
    }

    return null;
  }

  Problem? getProblem() {
    if (wrongProblems.isEmpty) {
      return null;
    }

    wrongProblems.shuffle();
    return wrongProblems[0];
  }

  void deleteProblem(Problem? problem) {
    if (problem == null) {
      return;
    }
    Problem? result = findProblem(problem);
    wrongProblems.remove(result);
  }

/// 将错题本转换成一个章节
  Section toSection(int subjectIndex) {
    Section section = Section(progress: 0);
    section.problems =
        DataManager.subjects[subjectIndex].faultBook.wrongProblems;
    section.problems!.shuffle();
    section.name = '${DataManager.subjects[subjectIndex].name}错题';

    return section;
  }
}
