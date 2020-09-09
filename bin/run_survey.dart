import 'dart:io';

import 'package:args/args.dart';
import 'package:mono_surveyor/src/determineDirectlyAffectedPackages.dart';
import 'package:mono_surveyor/src/determineTransitivelyAffectedPackages.dart';
import 'package:mono_surveyor/src/findAndValidatePackages.dart';
import 'package:mono_surveyor/src/findOriginDefaultBranch.dart';
import 'package:mono_surveyor/src/package.dart';
import 'package:mono_surveyor/src/runSurvey.dart';

void main(List<String> args) async {
  final List<Package> packages = findAndValidatePackages(prinResult: false);

  var parser = ArgParser();

  parser.addFlag("just-affected", defaultsTo: true);
  parser.addOption("survey");

  var results = parser.parse(args);

  List<Package> packagesToSurvey;

  if (results["survey"] == null) {
    print("No survey given");
    exit(1);
  }

  if (results["just-affected"] == true) {
    var res = await determineDirectlyAffectedPackages(
        packages: packages, ref: await findOriginDefaultBranch());

    List<Package> allAffectedPackages = [];
    res?.forEach((x) => determineTransitivelyAffectedPackages(
        affectedPackage: x,
        packages: packages,
        transitivelyAffectedPackages: allAffectedPackages));
    packagesToSurvey = allAffectedPackages;
  } else {
    packagesToSurvey = packages;
  }

  if (packagesToSurvey?.isEmpty ?? true) {
    print("Nothing to do");
    exit(0);
  }

  Map<String, String> env = {};
  for (var i = 0; i != results?.rest?.length; i += 2) {
    env[results.rest[i]] = results.rest[i + 1];
  }

  print("Packages to Survey:");
  packagesToSurvey?.forEach((element) => print("   ${element?.relativePath}"));
  await Future.forEach<Package>(
      packagesToSurvey,
      (element) =>
          runSurvey(package: element, survey: results["survey"], env: env));
}
