import 'dart:io';

import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

String packageName({@required String packagePath}) {
  final YamlMap doc =
      loadYaml(File("$packagePath/pubspec.yaml").readAsStringSync());

  return doc["name"];
}
