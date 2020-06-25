import 'package:surveyors/src/package.dart';
import 'package:meta/meta.dart';

void determineTransitivelyAffectedPackages(
    {@required Package affectedPackage,
    @required List<Package> packages,
    @required List<Package> transitivelyAffectedPackages}) {
  if (transitivelyAffectedPackages.firstWhere(
          (x) => x.dir == affectedPackage.dir,
          orElse: () => null) ==
      null) {
    transitivelyAffectedPackages.add(affectedPackage);
  }

  affectedPackage.friends.forEach((friend) {
    packages.forEach((pkg) {
      if (pkg.dir == friend) {
        determineTransitivelyAffectedPackages(
            affectedPackage: pkg,
            packages: packages,
            transitivelyAffectedPackages: transitivelyAffectedPackages);
      }
    });
  });
}
