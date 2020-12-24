import 'package:firebase_database/firebase_database.dart';

class User {
  String name, email, imgUrl, Uid;

  User({this.name, this.email, this.imgUrl, this.Uid}) : super();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      imgUrl: json['imgUrl'],
      Uid: json['Uid'],
    );
  }
}
