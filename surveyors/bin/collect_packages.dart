import 'dart:io';
import 'dart:math';

import 'package:surveyors/src/findAndValidatePackages.dart';
import 'package:surveyors/src/package.dart';

void main() async {
  List<Package> packages = findAndValidatePackages();
}
