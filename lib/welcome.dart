import 'dart:io';
import 'package:exercise_app/app/config.dart';
import 'package:exercise_app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WelcomePage extends StatefulWidget {
  final String? tag;

  const WelcomePage({Key? key, this.tag}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  LoginController loginController = Get.put(LoginController());

  var scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController =
      new RoundedLoadingButtonController();



  handleGoogleSignIn() async {
    loginController.signInWithGoogle(googleController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage(Config().logo),
                      height: 130,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedLoadingButton(
                      child: Wrap(
                        children: const [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Sign In with Google',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                      controller: googleController,
                      onPressed: () => handleGoogleSignIn(),
                      width: MediaQuery.of(context).size.width * 0.80,
                      color: Config().appColor,
                      elevation: 0,
                      //borderRadius: 3,
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
