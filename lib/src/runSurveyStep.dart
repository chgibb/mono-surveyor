import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

import 'package:mono_surveyor/src/package.dart';

Future<int> runSurveyStep(
    {@required Package package, @required String step}) async {
  Completer<int> completer = Completer<int>();

  List<String> parts = step.split(RegExp("\\s"));
  String exec = parts.removeAt(0);

  Process.start(exec, parts, workingDirectory: package.absolutePath)
      .then((process) {
    process.stdout.transform(utf8.decoder).listen((e) => print(e));
    process.stderr.transform(utf8.decoder).listen((e) => print(e));
    process.exitCode.then((value) => completer.complete(value));
  });

  return completer.future;
}
