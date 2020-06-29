import 'package:meta/meta.dart';

class Package {
  final String dir;
  final List<String> friends;
  final List<String> pathDependencies;

  Package(
      {@required this.dir,
      @required this.friends,
      @required this.pathDependencies});
}
