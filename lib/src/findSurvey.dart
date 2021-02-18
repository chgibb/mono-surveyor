import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'package:mono_surveyor/src/package.dart';
import 'package:mono_surveyor/src/surveyStep.dart';
import 'package:mono_surveyor/src/surveys.dart';

Future<List<SurveyStep>> findSurvey(
    {@required Package package, @required String survey}) async {
  try {
    var localFile = File("${package.relativePath}/surveys.json");
    RandomAccessFile file = localFile.openSync();

    Uint8List content = file.readSync(file.lengthSync());

    Surveys surveys = Surveys.fromJson(jsonDecode(utf8.decode(content)));

    file.closeSync();

    return surveys.surveys.entries
        .firstWhere(
          (x) => x.key == survey,
          orElse: () => null,
        )
        ?.value;
  } catch (err) {
    return null;
  }
}
