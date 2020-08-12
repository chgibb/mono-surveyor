import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'package:mono_surveyor/src/package.dart';

Future<List<String>> findSurvey(
    {@required Package package, @required String survey}) async {
  try {
    var localFile = File("${package.relativePath}/surveys.json");
    RandomAccessFile file = localFile.openSync();

    Uint8List content = file.readSync(file.lengthSync());

    Map<String, dynamic> json = jsonDecode(utf8.decode(content));

    file.closeSync();

    if (json["surveys"][survey] is List) {
      return json["surveys"][survey]?.toList()?.cast<String>();
    }
  } catch (err) {
    return null;
  }

  return null;
}
