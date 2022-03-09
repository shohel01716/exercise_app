import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/Screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginController extends GetxController{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

        debugPrint("login success:: "+userDetails.toString());
        googleController.success();

        Timer(const Duration(seconds: 1),() {
          Get.to(HomeScreen());
        });

      } catch (e) {
        debugPrint("_errorCode:: "+e.toString());
        googleController.error();
      }
    } else {
      debugPrint("googleUser:: null");
    }
  }
}