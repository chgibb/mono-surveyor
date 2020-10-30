import 'dart:io';

import 'package:args/args.dart';
import 'package:mono_surveyor/src/canSparseCheckout.dart';
import 'package:mono_surveyor/src/deleteSparseCheckoutFile.dart';
import 'package:mono_surveyor/src/disableSparseCheckout.dart';
import 'package:mono_surveyor/src/findAndValidatePackages.dart';
import 'package:mono_surveyor/src/initSparseCheckoutCone.dart';
import 'package:mono_surveyor/src/isWorkingTreeClean.dart';
import 'package:mono_surveyor/src/package.dart';
import 'package:mono_surveyor/src/removeEmptyDirectories.dart';
import 'package:mono_surveyor/src/removeUntrackedFiles.dart';
import 'package:mono_surveyor/src/resolveTopDownDependencyTree.dart';
import 'package:mono_surveyor/src/setSparseCheckoutPaths.dart';

void main(List<String> args) async {
  if (!await canSparseCheckout()) {
    print("Your version of git doesn't appear to support sparse checkouts");
    exit(1);
  }

  if (!await isWorkingTreeClean()) {
    print(
        "Working tree is not clean. Working tree must be clean before enabling focus mode");
    exit(1);
  }

  final List<Package> packages = findAndValidatePackages(prinResult: false);

  var parser = ArgParser();

  parser.addFlag("just-affected", defaultsTo: true);
  parser.addFlag("disable", defaultsTo: false);
  parser.addOption("package");

  var results = parser.parse(args);

  if (results["disable"] == true) {
    if (!await disableSparseCheckout()) {
      print("Failed to disable sparse checkout");
      exit(1);
    }

    await deleteSparseCheckoutFile();

    exit(0);
  }

  Package startingPackage = packages.firstWhere(
      (x) =>
          x.packageName.toLowerCase().trim() ==
          (results["package"] as String).toLowerCase().trim(),
      orElse: () => null);

  if (startingPackage == null) {
    print(
        "Could not focus on package \"${results["package"]}\". Package does not exist");
    exit(1);
  }

  List<Package> packagesToFocusOn = [];

  resolveTopDownDependencyTree(
      package: startingPackage,
      packages: packages,
      resolved: packagesToFocusOn);

  packagesToFocusOn.add(startingPackage);

  if (packagesToFocusOn?.isEmpty ?? true) {
    print("Nothing to focus on");
    exit(0);
  }

  print("Focusing on:");
  packagesToFocusOn.forEach((x) => print("  ${x.packageName}"));

  if (!await initSparseCheckoutCone()) {
    print("Failed to initialize sparse checkout cone");
    exit(1);
  }

  if (!await setSparseCheckoutPaths(packages: packagesToFocusOn)) {
    print("Failed to set sparse checkout paths");
    exit(1);
  }

  if (!await removeUntrackedFiles()) {
    print("Failed to remove untracked files");
    exit(1);
  }

  await removeEmptyDirectories(Directory.current);
}
