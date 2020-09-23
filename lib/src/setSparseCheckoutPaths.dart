import 'package:git/git.dart';
import 'package:mono_surveyor/src/package.dart';
import 'package:meta/meta.dart';

Future<bool> setSparseCheckoutPaths({
  @required List<Package> packages,
}) async {
  var res = await runGit([
    "sparse-checkout",
    "set",
    ".vscode",
    ".idea",
    "scripts",
    ...packages.map((e) => e?.relativePath)
  ]);
  //Default preserved paths should probably be configurable

  return res.exitCode == 0;
}
