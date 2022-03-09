import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {

  String? userName;
  String? imageUrl;
  String? userID;
  String? title;
  String? timestamp;


  Photo(
  {this.userName, this.imageUrl, this.userID, this.title, this.timestamp});

  factory Photo.fromFirestore(DocumentSnapshot snapshot){
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return Photo(
      userName: d['userName'],
      imageUrl: d['imageUrl'],
      title: d['title'],
      userID: d['userID'],
      timestamp: d['timestamp'],
    );
  }
}