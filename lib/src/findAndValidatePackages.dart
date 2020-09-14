import 'dart:io';

import 'package:path/path.dart';
import 'package:mono_surveyor/src/findPackages.dart';
import 'package:mono_surveyor/src/package.dart';
import 'package:mono_surveyor/src/packagePathDependencies.dart';
import 'package:mono_surveyor/src/resolvePathRelativeToRoot.dart';
import 'package:mono_surveyor/src/packageName.dart';

List<Package> findAndValidatePackages({bool prinResult = false}) {
  Map<String, String> packageNames = {};
  List<Package> packages = findPackages()
      ?.map((e) => Package(
          relativePath: relative(e, from: Directory.current.path),
          absolutePath: canonicalize(e),
          packageName: packageName(packagePath: e),
          pathDependencies: packagePathDependencies(packagePath: e)
              ?.map((x) =>
                  resolvePathRelativetoRoot(packagePath: e, relativePath: x))
              ?.toList()))
      ?.toList();
  packages
      ?.removeWhere((x) => RegExp("\\$separator\\.").hasMatch(x.absolutePath));
  packages?.forEach((x) {
    if (packageNames[x.packageName] != null) {
      throw "The package name ${x.packageName} has been declared multiple times";
    } else {
      packageNames[x.packageName] = "";
    }
  });

  if (prinResult) {
    packages?.forEach((element) {
      var packageInfo = (Package pkg) =>
          "${pkg?.packageName}:${pkg?.relativePath}  (${pkg?.absolutePath})";
      print(packageInfo(element));
      element?.pathDependencies?.forEach((x) {
        print("   $x");
      });
    });
  }

  return packages;
}
