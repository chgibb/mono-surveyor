import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';

import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

String resolvePathRelativetoRoot(
    {@required String packagePath, @required String relativePath}) {
  return canonicalize(Context(current: packagePath).canonicalize(relativePath));
}
