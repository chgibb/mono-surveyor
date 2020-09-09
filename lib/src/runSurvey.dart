import 'dart:io';

import 'package:meta/meta.dart';
import 'package:mono_surveyor/src/findSurvey.dart';

import 'package:mono_surveyor/src/package.dart';
import 'package:mono_surveyor/src/runSurveyStep.dart';

Future<void> runSurvey(
    {@required Package package,
    @required String survey,
    @required Map<String, String> env}) async {
  print("Running survey $survey on ${package.relativePath}");

  List<String> steps = await findSurvey(package: package, survey: survey);

  if (steps == null) {
    print("Package ${package?.relativePath} does not support $survey survey");
    exit(1);
  } else {
    await Future.forEach(steps, (element) async {
      var exitCode = await runSurveyStep(
        package: package,
        step: element,
        env: env,
      );
      if (exitCode != 0) {
        exit(exitCode);
      }
    });
  }
}
