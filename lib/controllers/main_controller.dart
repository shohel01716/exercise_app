import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/Screen/home_screen.dart';
import 'package:exercise_app/app/config.dart';
import 'package:exercise_app/controllers/login_controller.dart';
import 'package:exercise_app/models/photo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MainController extends GetxController{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  LoginController loginController = Get.find();

  @override
  void onInit() {
    addPhoto("Test", "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", loginController.userID.value, loginController.userName.value);
    getPhotos();
    super.onInit();
  }

  Future addPhoto (String title, String imageUrl, String userID, String name) async{
    getTimestamp();

    final DocumentReference ref = firestore.collection(Config().collectionPhotos).doc(timestamp);
    await ref.set({
      'title' : title,
      'imageUrl' : imageUrl,
      'userID' : userID,
      'userName' : name,
      'timestamp' : timestamp
    });
  }

  String timestamp = "";

  Future getTimestamp() async {
    DateTime now = DateTime.now();
    String _timestamp = now.millisecondsSinceEpoch.toString();
      timestamp = _timestamp;
  }


  List _categories = [];


  List<DocumentSnapshot> _snap = [];
  List<Photo> photos = <Photo>[].obs;

  Future getPhotos ()async{

    await firestore.collection(Config().collectionPhotos).limit(1).get().then((value)async{
      if(value.size != 0){
        QuerySnapshot snap = await firestore.collection(Config().collectionPhotos).get();
        _snap.addAll(snap.docs);

        debugPrint(">>>>>>>:: "+_snap.toString());

        photos.addAll(_snap.map((e) => Photo.fromFirestore(e)).toList());

        debugPrint(">>>>>>>:: "+photos.length.toString());

      }else{
        debugPrint(">>>>>>>:: getPhotos null");
      }

    });

  }

}