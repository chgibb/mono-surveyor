import 'package:path/path.dart';
import 'package:surveyors/src/findPackages.dart';
import 'package:surveyors/src/package.dart';
import 'package:surveyors/src/packagePathDependencies.dart';
import 'package:surveyors/src/resolvePathRelativeToRoot.dart';

List<Package> findAndValidatePackages({bool prinResult = false}) {
  List<Package> packages = findPackages()
      ?.map((e) => Package(
          relativePath: e,
          absolutePath: canonicalize(e),
          pathDependencies: packagePathDependencies(packagePath: e)
              ?.map((x) =>
                  resolvePathRelativetoRoot(packagePath: e, relativePath: x))
              ?.toList()))
      ?.toList();

  if (prinResult) {
    packages?.forEach((element) {
      print(element?.absolutePath);
      element?.pathDependencies?.forEach((x) {
        print("   $x");
      });
    });
  }

  return packages;
}
