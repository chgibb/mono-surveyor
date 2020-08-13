import 'package:git/git.dart';

Future<bool> disableSparseCheckout() async {
  var res = await runGit(["sparse-checkout", "disable"]);

  return res.exitCode == 0;
}
