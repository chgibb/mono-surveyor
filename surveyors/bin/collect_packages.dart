import 'dart:io';
import 'dart:math';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/src/generated/engine.dart' show AnalysisErrorInfoImpl;
import 'package:path/path.dart' as path;
import 'package:surveyor/src/analysis.dart';
import 'package:surveyor/src/driver.dart';
import 'package:surveyor/src/visitors.dart';
import 'package:surveyors/src/findAndValidatePackages.dart';
import 'package:surveyors/src/findPackages.dart';
import 'package:surveyors/src/isPackagePath.dart';
import 'package:surveyors/src/package.dart';
import 'package:surveyors/src/packageFriends.dart';

void main() async {
  List<Package> packages = findAndValidatePackages();
}
