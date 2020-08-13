import 'dart:io';

Future<void> deleteSparseCheckoutFile() async {
  await File(".git/info/sparse-checkout").delete();
}
