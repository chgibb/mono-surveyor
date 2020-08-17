import 'dart:io';

Future<void> removeEmptyDirectories(Directory dir) async {
  try {
    var contents = dir.listSync(recursive: true)?.toList();

    if (contents.isEmpty) {
      dir.deleteSync();
    } else {
      for (var entity in contents) {
        if (entity is Directory) {
          await removeEmptyDirectories(entity);
        }
      }
    }
  } catch (err) {}
}
