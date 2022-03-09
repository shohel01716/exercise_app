
import 'package:exercise_app/Const/local_color.dart';
import 'package:exercise_app/Const/local_image.dart';
import 'package:exercise_app/Const/margin.dart';
import 'package:exercise_app/Screen/Widget/text_widget.dart';
import 'package:exercise_app/Screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           elevation: 0,
        backgroundColor: appBG,
        centerTitle: true,
           title: boldtext("Photo Share"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
Get.to(UploadScreen());
        },
        tooltip: 'Upload',
        child: Image.asset(LocalImages.upload, height: 30,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                primary: false,
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index){
                  return post();
                }
            ),
          ],
        ),
      ),
    );
  }
  Widget post(){
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [

                Row(
                  children: [
                    text(
                        "@",textColor: grey, fontSize: 18
                    ),
                    text(
                        "Shohel Rana", textColor: textColorPrimary, fontSize: 18
                    ),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon:const Icon(Icons.more_vert),
                  iconSize: 30,
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Delete',}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice,),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
         SpaceH10(),
          Image.asset(LocalImages.logo),
          SpaceH10(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.timelapse_rounded,
                  color: grey,
                  size: 20,
                ),
                SpaceW10(),
                text("25 min", textColor: grey, fontSize: 12),


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: text("I am in chill mode", textColor: grey, fontSize: 12),
          )
        ],
      ),
    );
  }
  void handleClick(String value) {
    switch (value) {
      case 'Delete':
        break;
    }
  }
}
