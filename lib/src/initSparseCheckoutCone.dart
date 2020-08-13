import 'package:git/git.dart';

Future<bool> initSparseCheckoutCone() async {
  var res = await runGit(["sparse-checkout", "init", "--cone"]);

  return res.exitCode == 0;
}
