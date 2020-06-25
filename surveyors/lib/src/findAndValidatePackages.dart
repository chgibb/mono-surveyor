import 'dart:io';

import 'package:surveyors/src/findPackages.dart';
import 'package:surveyors/src/isPackagePath.dart';
import 'package:surveyors/src/package.dart';
import 'package:surveyors/src/packageFriends.dart';

List<Package> findAndValidatePackages() {
  List<Package> packages = findPackages()
      ?.map((e) => Package(dir: e, friends: packageFriends(packagePath: e)))
      ?.toList();

  packages?.forEach((e) {
    if (e?.friends == null) {
      print("Package ${e.dir} has no friend configuration");
      exit(1);
    }

    print("${e.dir}");
    e?.friends?.forEach((x) {
      if (!isPackagePath(packagePath: x)) {
        print(" $x is not a valid package");
        exit(1);
      }
      print("   ---> $x");
    });
  });

  return packages;
}
