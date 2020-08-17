import 'package:git/git.dart';
import 'package:mono_surveyor/src/package.dart';
import 'package:meta/meta.dart';

Future<bool> setSparseCheckoutPaths({
  @required List<Package> packages,
}) async {
  var res = await runGit(
      ["sparse-checkout", "set", ...packages.map((e) => e?.relativePath)]);

  return res.exitCode == 0;
}
