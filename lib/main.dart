
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:olx/authenti/phone_auth.dart';
import 'package:olx/screens/login_page.dart';
import 'package:olx/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting)
        {
          return MaterialApp(home: splashscreen());
        }
        else {
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.orangeAccent,
            ),
            home:login(),
            routes: {
              login.id:(context) =>login(),
              phoneauthscreen.id:(context) =>phoneauthscreen(),
            },
          );
        }
      },
    );
  }
}
