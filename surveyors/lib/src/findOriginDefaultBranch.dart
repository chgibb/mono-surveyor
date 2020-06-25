import 'package:git/git.dart';

Future<String> findOriginDefaultBranch() async {
  var res = await runGit(["rev-parse", "--abbrev-ref", "origin/HEAD"]);
  String originDefaultBranch = (res.stdout).trim();

  return originDefaultBranch;
}
