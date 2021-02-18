import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:mono_surveyor/src/package.dart';
import 'package:mono_surveyor/src/surveyStep.dart';

Future<int> runSurveyStep(
    {@required Package package,
    @required SurveyStep surveyStep,
    @required Map<String, String> env}) async {
  Completer<int> completer = Completer<int>();

  env?.keys?.forEach((x) {
    var regExp = RegExp(RegExp.escape(x), caseSensitive: true);
    var index =
        surveyStep.args.indexWhere((k) => regExp.stringMatch(k)?.isNotEmpty ?? false);

    while (index != -1) {
      surveyStep.args.setAll(index, [surveyStep.args[index].replaceAll(regExp, env[x])]);
      index =
          surveyStep.args.indexWhere((k) => regExp.stringMatch(k)?.isNotEmpty ?? false);
    }
  });

  Process.start(
    surveyStep.cmd,
    surveyStep.args,
    workingDirectory: package.absolutePath,
    runInShell: true,
  ).then((process) {
    process.stdout.transform(utf8.decoder).listen((e) => print(e));
    process.stderr.transform(utf8.decoder).listen((e) => print(e));
    process.exitCode.then((value) => completer.complete(value));
  });

  return completer.future;
}
