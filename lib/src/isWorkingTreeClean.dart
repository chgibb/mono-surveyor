import 'package:git/git.dart';

Future<bool> isWorkingTreeClean() async {
  var res = await runGit(["status", "--porcelain"]);
  String stdout = (res.stdout).trim();

  return stdout?.isEmpty ?? false;
}
