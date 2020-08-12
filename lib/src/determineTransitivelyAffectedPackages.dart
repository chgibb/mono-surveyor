import 'package:mono_surveyor/src/package.dart';
import 'package:meta/meta.dart';

void determineTransitivelyAffectedPackages(
    {@required Package affectedPackage,
    @required List<Package> packages,
    @required List<Package> transitivelyAffectedPackages}) {
  if (transitivelyAffectedPackages.firstWhere(
          (x) => x.relativePath == affectedPackage.relativePath,
          orElse: () => null) ==
      null) {
    transitivelyAffectedPackages.add(affectedPackage);
  } else {
    return;
  }

  packages?.forEach((pkg) {
    pkg?.pathDependencies?.forEach((dep) {
      if (transitivelyAffectedPackages?.firstWhere(
              (element) => element?.absolutePath == dep,
              orElse: () => null) !=
          null) {
        determineTransitivelyAffectedPackages(
            affectedPackage: pkg,
            packages: packages,
            transitivelyAffectedPackages: transitivelyAffectedPackages);
      }
    });
  });
}
