import 'package:git/git.dart';
import 'package:surveyors/src/package.dart';
import 'package:meta/meta.dart';

Future<List<Package>> determineDirectlyAffectedPackages(
    {@required String ref, @required List<Package> packages}) async {
  var diff = await runGit(["diff", ref]);

  var lines = (diff?.stdout as String)?.split("\n");

  List<Package> res = [];
  lines
      ?.where(
          (x) => RegExp("diff --git a/").stringMatch(x)?.isNotEmpty ?? false)
      ?.forEach((x) {
    res.addAll(packages
        .where((element) =>
            RegExp(RegExp.escape(element.dir), caseSensitive: false)
                ?.stringMatch(x)
                ?.isNotEmpty ??
            false)
        ?.toList());
  });

  return res;
}
