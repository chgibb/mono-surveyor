import 'package:git/git.dart';

Future<bool> canSparseCheckout() async {
  var res = await runGit(["sparse-checkout", "list"]);

  return res.exitCode == 0;
}
