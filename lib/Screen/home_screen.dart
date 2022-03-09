import 'package:exercise_app/Const/local_color.dart';
import 'package:exercise_app/Const/local_image.dart';
import 'package:exercise_app/Const/margin.dart';
import 'package:exercise_app/Screen/Widget/text_widget.dart';
import 'package:exercise_app/Screen/upload_screen.dart';
import 'package:exercise_app/controllers/main_controller.dart';
import 'package:exercise_app/models/photo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MainController mainController = Get.put(MainController());

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
        onPressed: () {
          Get.to(UploadScreen());
        },
        tooltip: 'Upload',
        child: Image.asset(
          LocalImages.upload,
          height: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(()=> ListView.builder(
                primary: false,
                itemCount: mainController.photos.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Photo item = mainController.photos.elementAt(index);
                  return post(item);
                })),
          ],
        ),
      ),
    );
  }

  Widget post(Photo item) {
    return Padding(
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
                    text("@", textColor: grey, fontSize: 18),
                    text(item.userName!,
                        textColor: textColorPrimary, fontSize: 18),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  iconSize: 30,
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {
                      'Delete',
                    }.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
          SpaceH10(),
          Image.network(item.imageUrl!),
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
                text(readTimestamp(int.parse(item.timestamp!)), textColor: grey, fontSize: 12),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: text(item.title!, textColor: grey, fontSize: 12),
          )
        ],
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Delete':
        Get.snackbar("Delete", "This feature not working now!");
        break;
    }
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }
}
