import 'package:git/git.dart';
import 'package:mono_surveyor/src/package.dart';
import 'package:meta/meta.dart';

Future<List<Package>> determineDirectlyAffectedPackages(
    {@required String ref, @required List<Package> packages}) async {
  var diff = await runGit(["diff", ref]);

  var diffLines = (diff?.stdout as String)?.split("\n");

  List<Package> res = [];
  diffLines
      ?.where(
          (x) => RegExp("diff --git a/").stringMatch(x)?.isNotEmpty ?? false)
      ?.forEach((x) {
    res.addAll(packages
        .where((element) =>
            RegExp(RegExp.escape(element.relativePath), caseSensitive: false)
                ?.stringMatch(x)
                ?.isNotEmpty ??
            false)
        ?.toList());
  });

  var newFile = await runGit(["ls-files", "--others", "--exclude-standard"]);
  var newFileLines = (newFile?.stdout as String)?.split("\n");

  newFileLines?.forEach((x) {
    res.addAll(packages
        .where((element) =>
            RegExp(RegExp.escape(element.relativePath), caseSensitive: false)
                ?.stringMatch(x)
                ?.isNotEmpty ??
            false)
        ?.toList());
  });

  return res;
}
