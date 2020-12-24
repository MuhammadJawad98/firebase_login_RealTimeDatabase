import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/Fragments/Profile/ProfilePage.dart';

import 'BaseAuth.dart';
import 'model/User.dart';
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MainPage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Fragment 1", Icons.rss_feed),
    new DrawerItem("Fragment 2", Icons.local_pizza),
    new DrawerItem("Fragment 3", Icons.info)
  ];

  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {


  dynamic data;
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new Profile();
      case 1:
        return new Profile();
      case 2:
        return new Profile();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
  Auth auth=Auth();
  UserInfo user;
  User usr;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    // getData();
    // user =await auth.getCurrentUser();
  // await auth.getUserInto(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(''), accountEmail: Text('')),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
  // void getData()async{ //use a Async-await function to get the data
  //   final data =  await Firestore.instance.collection("users").document('BBXuDKTZudHz7QfP15Rg').get(); //get the data
  //   DocumentSnapshot  snapshot = data;
  //   print('Data:::'+snapshot.data['searchRadius']);
  // }
}