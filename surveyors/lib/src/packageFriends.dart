import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';

List<String> packageFriends({@required packagePath}) {
  if (File("$packagePath/friends.json").existsSync()) {
    var localFile = File("$packagePath/friends.json");
    RandomAccessFile file = localFile.openSync();

    Uint8List content = file.readSync(file.lengthSync());

    List<dynamic> json = jsonDecode(utf8.decode(content));

    file.closeSync();

    return json.map((e) => e.toString()).toList();
  }

  return null;
}
