import 'package:meta/meta.dart';

class Package {
  final String relativePath;
  final String absolutePath;
  final List<String> pathDependencies;

  Package(
      {@required this.relativePath,
      @required this.absolutePath,
      @required this.pathDependencies});
}
