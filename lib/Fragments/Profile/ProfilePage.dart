import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/Fragments/Profile/components/detailText.dart';
import 'package:flutter_firebase_login/model/User.dart';

import '../../BaseAuth.dart';
import 'components/CutomImg.dart';
import 'components/ProfileText.dart';

class Profile extends StatefulWidget {
  // User userInfo;
  //
  // Profile({this.userInfo});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Auth auth = Auth();
  FirebaseUser user;
  String imgUrl;
  // Future<User> futureUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomImage(imgUrl: imgUrl,),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileText(
                text: "Follower",
                numbers: 3057,
              ),
              ProfileText(
                text: "Following",
                numbers: 274,
              ),
              ProfileText(
                text: "Collection",
                numbers: 52,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Divider(
              height: 10,
              thickness: 1,
              color: Colors.pink,
            ),
          ),
          DetailText(
            icon: Icons.mail,
            txt: 'lukeith@gmail.com',
          ),
          DetailText(
            icon: Icons.phone,
            txt: '+82 95 5808 2654 ',
          ),
          DetailText(
            icon: Icons.public,
            txt: 'www.lukeith.com  ',
          ),
          FlatButton(
              onPressed: () async {
                Auth auth = Auth();
                await auth.signOut();
                Navigator.pop(context);
              },
              child: Text('Signout')),
        ],
      ),
    );
  }

  Future<void> getdata() async {
    user = await auth.getCurrentUser();
    // futureUser =
    fetchUser(user);

  }

  Future<User> fetchUser(FirebaseUser user) {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('users').child(user.uid).once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value['name']}');
      setState(() {
        imgUrl=snapshot.value['imgUrl'];
      });
      // return User.fromJson(jsonDecode(snapshot.value));
    });
  }
}
