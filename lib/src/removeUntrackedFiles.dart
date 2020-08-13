import 'package:git/git.dart';

Future<bool> removeUntrackedFiles() async {
  var res = await runGit(["clean", "-xdf"]);

  return res.exitCode == 0;
}
