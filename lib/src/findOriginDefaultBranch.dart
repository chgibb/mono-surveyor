import 'package:git/git.dart';

Future<String> findOriginDefaultBranch() async {
  var res = await runGit(["remote", "show", "origin"]);
  var lines = (res.stdout as String)?.split("\n");

  String originDefaultBranch;
  originDefaultBranch = lines
          ?.firstWhere(
              (x) => RegExp("HEAD branch:").stringMatch(x)?.isNotEmpty ?? false)
          ?.replaceAll("HEAD branch:", "")
          ?.trim() ??
      "";

  return originDefaultBranch;
}
