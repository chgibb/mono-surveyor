import 'dart:io';

Future<void> deleteSparseCheckoutFile() async {
  try {
    await File(".git/info/sparse-checkout").delete();
  } catch (err) {
    //This isn't an error state
  }
}
