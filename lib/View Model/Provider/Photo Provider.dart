import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';


class PhotoProvider extends ChangeNotifier{
  final ImagePicker image = ImagePicker();
   File? imagefile;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth =FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String imageurl = '';

 Future<void> getimage(ImageSource src)async {
    final pickedfile = await image.pickImage(source: src,imageQuality: 100,maxHeight: 650);
    if(pickedfile!=null){
      imagefile=File(pickedfile.path);
      await storage.ref().child('images/${Uri.file(imagefile!.path).pathSegments.last}')
          .putFile(imagefile!)
   .then((value) {
     value.ref.getDownloadURL().then((value){
       imageurl=value;
       print(value);});
      });
      await firestore.collection('users').doc(auth.currentUser!.uid).update({
        'image':imageurl
      });
      firestore.collection("users").where("uId", isEqualTo: auth.currentUser!.uid).get().then((value) {
        value.docs.forEach((element) {
          firestore.collection("users").doc(element.id).update({"image": imageurl});
        });
      });


      notifyListeners();
    }
    else{print("no image selected");}
 }

}