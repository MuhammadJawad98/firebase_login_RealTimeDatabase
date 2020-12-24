import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'MainPage.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'constants.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MySplashScreen(),
    debugShowCheckedModeBanner: false,
    title: 'Flutter Auth',
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MyApp(),
      title: new Text(
        'Firebase',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50.0,
            fontFamily: 'Roboto',
            color: Colors.white),
      ),
      // image: Image.asset('assets/icons/signup.svg'),
      backgroundColor: Colors.purple,
      loaderColor: Colors.white,
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          // FirebaseUser user = snapshot.data; // this is your user instance
          /// is because there is user already logged
          return MainPage();
        } else {
          return WelcomeScreen();
        }

        /// other way there is no user logged.
      });
  }
}
