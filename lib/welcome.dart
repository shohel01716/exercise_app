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
  final RoundedLoadingButtonController _googleController = new RoundedLoadingButtonController();

  handleSkip (){
    /*final sb = context.read<SignInBloc>();
    sb.setGuestUser();
    nextScreen(context, DonePage());*/

  }






  handleGoogleSignIn() async{

    loginController.signInWithGoogle();

    /*final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    await AppService().checkInternet().then((hasInternet)async{
      if(hasInternet == false){
        openSnacbar(scaffoldKey, 'check your internet connection!'.tr());
      }
      else{
        await sb.signInWithGoogle().then((_){
        if(sb.hasError == true){
          openSnacbar(scaffoldKey, 'something is wrong. please try again.'.tr());
          _googleController.reset();

        }else {
          sb.checkUserExists().then((value){
          if(value == true){
            sb.getUserDatafromFirebase(sb.uid)
            .then((value) => sb.guestSignout())
            .then((value) => sb.saveDataToSP()
            .then((value) => sb.setSignIn()
            .then((value){
              _googleController.success();
              handleAfterSignIn();
            })));
          } else{
            sb.getTimestamp()
            .then((value) => sb.saveToFirebase()
            .then((value) => sb.increaseUserCount())
            .then((value) => sb.guestSignout())
            .then((value) => sb.saveDataToSP()
            .then((value) => sb.setSignIn()
            .then((value){
              _googleController.success();
              handleAfterSignIn();
            }))));
          }
            });

        }
      });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          widget.tag != null
              ? Container()
              : TextButton(
                  onPressed: () => handleSkip(),
                  child: Text('skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),),

        ],
      ),
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
                )),

            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedLoadingButton(

              child: Wrap(
                children: [
                  //Icon(FontAwesome.google, size: 25, color: Colors.white,),
                  SizedBox(width: 15,),
                  Text('Sign In with Google', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),)
                ],
              ),
              controller: _googleController,
              onPressed: ()=> handleGoogleSignIn(),
              width: MediaQuery.of(context).size.width * 0.80,
                    color: Config().appColor,
              elevation: 0,
              //borderRadius: 3,

            ),
          ],
        ),
      ),
    ]
    ),
    ));
  }

}