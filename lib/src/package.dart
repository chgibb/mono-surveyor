import 'package:meta/meta.dart';

class Package {
  final String relativePath;
  final String absolutePath;
  final String packageName;
  final List<String> pathDependencies;

  Package(
      {@required this.relativePath,
      @required this.absolutePath,
      @required this.packageName,
      @required this.pathDependencies});
}
