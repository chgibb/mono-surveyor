import 'package:path/path.dart';
import 'package:meta/meta.dart';

String resolvePathRelativetoRoot(
    {@required String packagePath, @required String relativePath}) {
  return canonicalize(Context(current: packagePath).canonicalize(relativePath));
}
