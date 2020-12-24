import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/Screens/Login/components/background.dart';
import 'package:flutter_firebase_login/Screens/Signup/components/or_divider.dart';
import 'package:flutter_firebase_login/Screens/Signup/components/social_icon.dart';
import 'package:flutter_firebase_login/Screens/Signup/signup_screen.dart';
import 'package:flutter_firebase_login/components/already_have_an_account_acheck.dart';
import 'package:flutter_firebase_login/components/rounded_button.dart';
import 'package:flutter_firebase_login/components/rounded_input_field.dart';
import 'package:flutter_firebase_login/components/rounded_password_field.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../BaseAuth.dart';
import '../../../MainPage.dart';
import 'button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool visible;
  Auth auth;
  var email, password;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

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
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.02),
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
              text: "LOGIN",
              press: () async {
                setState(() {
                  visible = true;
                });
                var userId = await auth.signIn(
                    email.toString().trim(), password.toString().trim());
                if (userId == 'ERROR_USER_NOT_FOUND') {
                  setState(() {
                    visible = false;
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Email Not Registered.....'),
                  ));
                } else if (userId != null) {
                  setState(() {
                    visible = false;
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                  print(userId);
                }
              },
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            // MaterialButton(
            //   child: button('Google', 'assets/google.png'),
            //   onPressed: () {
            //     _signIn(context)
            //         .then((FirebaseUser user) => print(user))
            //         .catchError((e) => print(e));
            //   },
            //   color: Colors.white,
            // ),
            // MaterialButton(
            //   child: button('Facebook', 'assets/facebook.png', Colors.white),
            //   onPressed: () {},
            //   color: Color.fromRGBO(58, 89, 152, 1.0),
            // ),
            Visibility(
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
                  press: () {
                    _signIn(context).then((FirebaseUser user) {
                      print(user);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    }).catchError((e) => print(e));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails =
        (await _firebaseAuth.signInWithCredential(credential)) as FirebaseUser;
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
    return userDetails;
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);

  final String providerDetails;
}
