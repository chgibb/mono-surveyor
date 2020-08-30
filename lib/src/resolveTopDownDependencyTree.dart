import 'package:meta/meta.dart';
import 'package:mono_surveyor/src/package.dart';

void resolveTopDownDependencyTree(
    {@required Package package,
    @required List<Package> packages,
    @required List<Package> resolved}) {
  packages.forEach((x) {
    if (package.pathDependencies
                .firstWhere((k) => k == x.absolutePath, orElse: () => null) !=
            null &&
        resolved.firstWhere((k) => k.absolutePath == x.absolutePath,
                orElse: () => null) ==
            null) {
      resolved.add(x);
      resolveTopDownDependencyTree(
          package: x, packages: packages, resolved: resolved);
    }
  });
}
