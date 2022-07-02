import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  /// The main Firestore user collection
  static Future<String> uploadFileTofireStorage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final mountainImagesRef =
          storageRef.child("images/${image.path.split('/').last}");
      UploadTask _uploadTask = mountainImagesRef.putFile(image);
      await _uploadTask.whenComplete(() 
      {
        log('Image Completed');
      });
      return await mountainImagesRef.getDownloadURL();
      return await _uploadTask.snapshot.ref.getDownloadURL();
      final String imageUrl = await mountainImagesRef.getDownloadURL();
      log(imageUrl.toString());
      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }
}
