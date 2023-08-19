import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fireStoreMethodsProvider = Provider<FireStoreMethods>((ref) {
  return FireStoreMethods();
});

class FireStoreMethods with ChangeNotifier {
  FireStoreMethods();
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadImage(
    String path,
    File file,
  ) async {
    UploadTask uploadTask = storage.ref().child(path).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String dt = await taskSnapshot.ref.getDownloadURL();
    return dt;
  }
}
