import 'dart:io';

import 'package:meta/meta.dart';

bool isPackagePath({@required String packagePath}) {
  return File("$packagePath/pubspec.yaml").existsSync();
}
