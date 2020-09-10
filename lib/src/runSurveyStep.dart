import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:mono_surveyor/src/package.dart';

Future<int> runSurveyStep(
    {@required Package package,
    @required String step,
    @required Map<String, String> env}) async {
  Completer<int> completer = Completer<int>();

  List<String> parts = step.split(RegExp("\\s"));
  String exec = parts.removeAt(0);

  env?.keys?.forEach((x) {
    var regExp = RegExp(RegExp.escape(x), caseSensitive: true);
    var index =
        parts.indexWhere((k) => regExp.stringMatch(k)?.isNotEmpty ?? false);

    while (index != -1) {
      parts.setAll(index, [parts[index].replaceAll(regExp, env[x])]);
      index =
          parts.indexWhere((k) => regExp.stringMatch(k)?.isNotEmpty ?? false);
    }
  });

  Process.start(
    exec,
    parts,
    workingDirectory: package.absolutePath,
    runInShell: true,
  ).then((process) {
    process.stdout.transform(utf8.decoder).listen((e) => print(e));
    process.stderr.transform(utf8.decoder).listen((e) => print(e));
    process.exitCode.then((value) => completer.complete(value));
  });

  return completer.future;
}
