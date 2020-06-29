import 'package:surveyors/src/findPackages.dart';
import 'package:surveyors/src/package.dart';
import 'package:surveyors/src/packageFriends.dart';
import 'package:surveyors/src/packagePathDependencies.dart';
import 'package:surveyors/src/resolvePathRelativeToRoot.dart';

List<Package> findAndValidatePackages() {
  List<Package> packages = findPackages()
      ?.map((e) => Package(
          dir: e,
          friends: packageFriends(packagePath: e),
          pathDependencies: packagePathDependencies(packagePath: e)
              ?.map((x) =>
                  resolvePathRelativetoRoot(packagePath: e, relativePath: x))
              ?.toList()))
      ?.toList();

  packages?.forEach((element) {
    print(element?.dir);
    element?.pathDependencies?.forEach((x) {
      print("   $x");
    });
  });

  return packages;
}
