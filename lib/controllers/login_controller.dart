import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/Screen/home_screen.dart';
import 'package:exercise_app/Screen/upload_screen.dart';
import 'package:exercise_app/app/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginController extends GetxController{

  var userID = "".obs;
  var userName = "".obs;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    getUser();
    getName();
    super.onInit();
  }

  Future signInWithGoogle(RoundedLoadingButtonController googleController) async {
    final GoogleSignInAccount? googleUser = await _googlSignIn.signIn();
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        User userDetails = (await _firebaseAuth.signInWithCredential(credential)).user!;

        /*this._name = userDetails.displayName;
        this._email = userDetails.email;
        this._imageUrl = userDetails.photoURL;
        this._uid = userDetails.uid;
        this._signInProvider = 'google';*/

        saveUser(userDetails.uid);
        saveName(userDetails.displayName);

        debugPrint("login success:: "+userDetails.toString());
        googleController.success();

        /*Timer(const Duration(seconds: 1),() {
          Get.to(UploadScreen());
        });*/

        Get.to(() => UploadScreen());

      } catch (e) {
        debugPrint("_errorCode:: "+e.toString());
        googleController.error();
      }
    } else {
      debugPrint("googleUser:: null");
    }
  }

  var localRef = GetStorage();

  saveUser(id) async {
    userID.value = id;
    await localRef.write(Config().userID, id);
  }

  getUser() async {
    String userId = await localRef.read(Config().userID);
    userID.value = userId;
  }

  saveName(name) async {
    userName.value = name;
    await localRef.write(Config().userName, name);
  }

  getName() async {
    String name = await localRef.read(Config().userName);
    userName.value = name;
  }
}