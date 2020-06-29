import 'package:surveyors/src/determineDirectlyAffectedPackages.dart';
import 'package:surveyors/src/determineTransitivelyAffectedPackages.dart';
import 'package:surveyors/src/findAndValidatePackages.dart';
import 'package:surveyors/src/findOriginDefaultBranch.dart';
import 'package:surveyors/src/package.dart';

void main() async {
  List<Package> packages = findAndValidatePackages();

  var res = await determineDirectlyAffectedPackages(
      packages: packages, ref: await findOriginDefaultBranch());

  print("The following packages have been directly changed:");
  res?.forEach((element) => print("   ${element?.relativePath}"));

  List<Package> allAffectedPackages = [];
  print("The following packages have been affected:");
  res?.forEach((x) => determineTransitivelyAffectedPackages(
      affectedPackage: x,
      packages: packages,
      transitivelyAffectedPackages: allAffectedPackages));
  allAffectedPackages?.forEach((element) => print("   ${element?.relativePath}"));
}
