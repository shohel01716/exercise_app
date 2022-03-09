import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:exercise_app/Const/local_color.dart';
import 'package:exercise_app/Const/margin.dart';
import 'package:exercise_app/Screen/Widget/text_widget.dart';
import 'package:exercise_app/controllers/login_controller.dart';
import 'package:exercise_app/controllers/main_controller.dart';
import 'package:exercise_app/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Widget/primary_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  MainController mainController = Get.find();
  var titleController = TextEditingController();
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {

    getStoragePermission();

    loginCheck();
    super.initState();
  }

  loginCheck(){
    if(loginController.userID.value == null || loginController.userID.value.isEmpty){

      Timer(const Duration(seconds: 1),() {
          Get.to(() => const LoginScreen());
        });

    }

  }

  getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (kDebugMode) {
      print(statuses[Permission.storage]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBG,
        leading: InkWell(
          onTap: () {
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
              SizedBox(
                child: TextField(
                  controller: titleController,
                  maxLines: 1,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Whats going on!',
                    hintText: 'Type here',
                  ),
                ),
              ),
              SpaceH10(),
              boldtext("Upload Image"),
              SpaceH10(),
              InkWell(
                onTap: () async {
                  getStoragePermission();

                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );

                  if (result != null) {
                    Get.snackbar("Please Wait", 'Image Uploading', duration: const Duration(seconds: 10));

                    File? file = File(result.files.first.path!);

                    String filename = result.files.first.name;

                    debugPrint('>>>filename>>>>' + filename);

                    firebase_storage.Reference storageRef = firebase_storage
                        .FirebaseStorage.instance
                        .ref()
                        .child('photos/$filename');

                    final metadata = firebase_storage.SettableMetadata(
                      contentType: 'image/jpeg',
                      customMetadata: {'picked-file-path': filename},
                    );

                    final firebase_storage.UploadTask uploadTask =
                        storageRef.putFile(file, metadata);

                    final firebase_storage.TaskSnapshot downloadUrl =
                        await uploadTask;

                    final String attchurl =
                        (await downloadUrl.ref.getDownloadURL());

                    debugPrint(">>>>url:: " + attchurl);

                    imageUrl = attchurl;

                    setState(() {});

                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        imageUrl.isNotEmpty ? Card(child: Center(child: Image.network(imageUrl, fit: BoxFit.cover, width: Get.width,))) : const SizedBox(),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.cloud_upload_outlined),
                              text("Upload Image"),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              SpaceH100(),
              PrimaryButton(
                windowWidth: Get.width,
                color: Colors.blue,
                buttonTitle: "Share",
                onPressed: () async {

                  if(imageUrl.isEmpty){
                    Get.snackbar("Empty!", 'Upload and share', duration: const Duration(seconds: 3));
                    return;
                  }

                  Get.snackbar("Shared", 'Your photo successfully shared', duration: const Duration(seconds: 3));

                  await mainController.addPhoto(titleController.text, imageUrl);

                  //Navigator.pop(context);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String imageUrl = "";
}
