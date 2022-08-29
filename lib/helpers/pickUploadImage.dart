import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<dynamic, dynamic>> pickUploadImage(ref) async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: 512,
    maxHeight: 512,
    imageQuality: 75,
  );

  ref != ''
      ? ref = FirebaseStorage.instance.ref().child(ref)
      : ref = FirebaseStorage.instance.ref().child(
          DateTime.now().millisecondsSinceEpoch.toString() + "image.jpg");

  await ref.putFile(File(image!.path));
  final imageUrl = await ref.getDownloadURL();
  Map imageData = {};
  imageData['imageRef'] = ref.fullPath;
  imageData['imageUrl'] = imageUrl;
  imageData['widgetPhoto'] = Image.network(imageUrl, fit: BoxFit.cover);
  return imageData;
}
