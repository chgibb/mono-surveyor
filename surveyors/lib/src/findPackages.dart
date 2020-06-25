import 'dart:io';

import 'package:surveyors/src/isPackagePath.dart';

List<String> findPackages() {
  var baseDirs = ["packages", "apps"];

  List<String> dirs = [];

  baseDirs.forEach((dir) {
    dirs.addAll(Directory(dir)
        .listSync(recursive: true)
        .where((element) => element is Directory)
        ?.toList()
        ?.map((e) => e?.path)
        ?.toList());
  });

  return dirs
      ?.where((element) => isPackagePath(packagePath: element))
      ?.toList();
}
