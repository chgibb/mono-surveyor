import 'dart:io';

import 'package:meta/meta.dart';
import 'package:mono_surveyor/src/findSurvey.dart';

import 'package:mono_surveyor/src/package.dart';
import 'package:mono_surveyor/src/runSurveyStep.dart';
import 'package:mono_surveyor/src/surveyStep.dart';

Future<void> runSurvey(
    {@required Package package,
    @required String surveyName,
    @required Map<String, String> env}) async {
  print("Running survey $surveyName on ${package.relativePath}");

  List<SurveyStep> surveySteps =
      await findSurvey(package: package, survey: surveyName);

  if (surveySteps == null) {
    print("Package ${package?.relativePath} does not support $surveyName survey");
    exit(1);
  } else {
    await Future.forEach(surveySteps, (element) async {
      var exitCode = await runSurveyStep(
        package: package,
        surveyStep: element,
        env: env,
      );
      if (exitCode != 0) {
        exit(exitCode);
      }
    });
  }
}
