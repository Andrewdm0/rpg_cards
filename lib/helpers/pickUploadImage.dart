import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpg_cards/helpers/image_crop.dart';

Future<Map<dynamic, dynamic>> pickUploadImage(ref,id,context) async {

  var db = FirebaseFirestore.instance;
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

  if(id != null){
    db
        .collection('characters')
        .doc(id)
        .update({'imageRef': '${imageData['imageRef']}'});
    db
        .collection('characters')
        .doc(id)
        .update({'image': '${imageData['imageUrl']}'});
  }

  return imageData;
}
