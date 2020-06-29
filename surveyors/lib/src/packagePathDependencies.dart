import 'dart:io';

import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

String _extractPathDependency({@required YamlMap dep}) {
  if (dep != null) {
    if (dep["path"] != null) {
      return dep["path"];
    }
  }
  return null;
}

List<String> packagePathDependencies({@required String packagePath}) {
  List<String> res = [];
  final YamlMap doc =
      loadYaml(File("$packagePath/pubspec.yaml").readAsStringSync());
  doc["dependencies"].keys?.forEach((element) {
    var dep = doc["dependencies"][element];
    if (dep is YamlMap) {
      var path = _extractPathDependency(dep: dep);
      if (path != null) {
        res.add(path);
      }
    }
  });

  doc["dev_dependencies"].keys?.forEach((element) {
    var dep = doc["dev_dependencies"][element];
    if (dep is YamlMap) {
      var path = _extractPathDependency(dep: dep);
      if (path != null) {
        res.add(path);
      }
    }
  });

  return res;
}
