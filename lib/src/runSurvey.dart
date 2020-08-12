import 'dart:io';

import 'package:meta/meta.dart';
import 'package:surveyors/src/findSurvey.dart';

import 'package:surveyors/src/package.dart';
import 'package:surveyors/src/runSurveyStep.dart';

Future<void> runSurvey(
    {@required Package package, @required String survey}) async {
  print("Running survey $survey on ${package.relativePath}");

  List<String> steps = await findSurvey(package: package, survey: survey);

  if (steps == null) {
    print("Package ${package?.relativePath} does not support $survey survey");
    exit(1);
  } else {
    await Future.forEach(steps, (element) async {
      var exitCode = await runSurveyStep(package: package, step: element);
      if (exitCode != 0) {
        exit(exitCode);
      }
    });
  }
}
