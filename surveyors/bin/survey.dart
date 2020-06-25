//  Copyright 2019 Google LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/src/generated/engine.dart' show AnalysisErrorInfoImpl;
import 'package:path/path.dart' as path;
import 'package:surveyor/src/analysis.dart';
import 'package:surveyor/src/driver.dart';
import 'package:surveyor/src/visitors.dart';
import 'package:surveyors/friendVisibility.dart';
import 'package:surveyors/print.dart';
import 'package:surveyors/src/findAndValidatePackages.dart';
import 'package:surveyors/src/package.dart';

/// Lints specified projects with a defined set of lints.
///
/// Run like so:
///
/// dart example/lint_surveyor.dart <source dir>
void main(List<String> args) async {
  var stopwatch = Stopwatch()..start();

  List<Package> packages = findAndValidatePackages();

  if (args.length == 1) {
    var dir = args[0];
    if (!File('$dir/pubspec.yaml').existsSync()) {
      print("Recursing into '$dir'...");

      args = Directory(dir)
          .listSync()
          .where(
              (f) => !path.basename(f.path).startsWith('.') && f is Directory)
          .map((f) => f.path)
          .toList()
            ..sort();
      dirCount = args.length;
      print('(Found $dirCount subdirectories.)');
    }
  }

  if (_debuglimit != null) {
    print('Limiting analysis to $_debuglimit packages.');
  }

  var driver = Driver.forArgs(args);
  driver.visitor = AnalysisAdvisor();
  driver.showErrors = true;

  driver.lints = [
    PrintSurveyor(),
    FriendVisibilitySurveyor(packages: packages)
  ];

  await driver.analyze();

  print(
      '(Elapsed time: ${Duration(milliseconds: stopwatch.elapsedMilliseconds)})');
}

int dirCount;

/// If non-null, stops once limit is reached (for debugging).
int _debuglimit; // = 300;

class AnalysisAdvisor extends SimpleAstVisitor
    implements
        PreAnalysisCallback,
        PostAnalysisCallback,
        PostVisitCallback,
        ErrorReporter {
  int count = 0;

  AnalysisStats stats;
  HumanErrorFormatter formatter;

  AnalysisAdvisor() {
    stats = AnalysisStats();
    formatter = HumanErrorFormatter(stdout, stats);
  }

  @override
  void onVisitFinished() {
    stats.print();
  }

  @override
  void postAnalysis(SurveyorContext context, DriverCommands cmd) {
    cmd.continueAnalyzing = _debuglimit == null || count < _debuglimit;
  }

  @override
  void preAnalysis(SurveyorContext context,
      {bool subDir, DriverCommands commandCallback}) {
    if (subDir) {
      ++dirCount;
    }
    var root = context.analysisContext.contextRoot.root;
    var dirName = path.basename(root.path);
    if (subDir) {
      // Qualify.
      dirName = '${path.basename(root.parent.path)}/$dirName';
    }
    print("Analyzing '$dirName' • [${++count}/$dirCount]...");
  }

  @override
  void reportError(AnalysisResultWithErrors result) {
    var errors = result.errors.toList();
    if (errors.isEmpty) {
      return;
    }
    formatter.formatErrors([AnalysisErrorInfoImpl(errors, result.lineInfo)]);
    formatter.flush();
  }
}
