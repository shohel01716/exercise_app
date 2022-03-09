import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/Screen/home_screen.dart';
import 'package:exercise_app/app/config.dart';
import 'package:exercise_app/controllers/login_controller.dart';
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
    addPhoto("Test", "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", loginController.userID.value);
    super.onInit();
  }

  Future addPhoto (String title, String imageUrl, String userID) async{
    getTimestamp();

    final DocumentReference ref = firestore.collection(Config().collectionPhotos).doc(timestamp);
    await ref.set({
      'title' : title,
      'imageUrl' : imageUrl,
      'userID' : userID,
      'timestamp' : timestamp
    });
  }

  String timestamp = "";

  Future getTimestamp() async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
      timestamp = _timestamp;
  }



}