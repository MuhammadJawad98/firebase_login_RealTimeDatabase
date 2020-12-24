import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/Screens/Login/login_screen.dart';
import 'package:flutter_firebase_login/Screens/Signup/components/background.dart';
import 'package:flutter_firebase_login/Screens/Signup/components/social_icon.dart';
import 'package:flutter_firebase_login/components/already_have_an_account_acheck.dart';
import 'package:flutter_firebase_login/components/rounded_button.dart';
import 'package:flutter_firebase_login/components/rounded_input_field.dart';
import 'package:flutter_firebase_login/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../BaseAuth.dart';
import '../../../MainPage.dart';
import 'or_divider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool visible;
  var email, password;
  Auth auth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = false;
    auth = Auth();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async{
                setState(() {
                  visible=true;
                });
                var userId = await auth.signUp(email.toString().trim(), password.toString().trim());
               if(userId == 'ERROR_EMAIL_ALREADY_IN_USE'){
                 setState(() {
                   visible=false;
                 });
                 Scaffold.of(context).showSnackBar(SnackBar(
                   content: Text('Email Already Registered....'),
                 ));
               }
                else if (userId != null) {
                  setState(() {
                    visible=false;
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainPage()));
                  print(userId);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),Visibility(
              child: CircularProgressIndicator(),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: visible,
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  }
