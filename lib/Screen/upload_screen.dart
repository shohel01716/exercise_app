import 'package:exercise_app/Const/local_color.dart';
import 'package:exercise_app/Const/margin.dart';
import 'package:exercise_app/Screen/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widget/primary_button.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBG,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: grey,
          ),
        ),
        title: boldtext(
          "Upload Image",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldtext("Whats on your mind??"),
              SpaceH10(),
              const SizedBox(
                child: TextField(
                  maxLines: 1,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Whats going on!',
                    hintText: 'Type here',
                  ),
                ),
              ),
              SpaceH10(),
              boldtext("Upload Image"),
              SpaceH10(),
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_upload_outlined),
                        text("Upload Image"),
                      ],
                    ),
                  )),
              SpaceH100(),
              PrimaryButton(
                windowWidth: Get.width,
                color: Colors.blue,
                buttonTitle: "Post",
                onPressed: () {
//TODO Function added
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
