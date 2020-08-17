import 'dart:io';

import 'package:mono_surveyor/src/isPackagePath.dart';

List<String> findPackages() {
  var baseDirs = [Directory.current.path];

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
