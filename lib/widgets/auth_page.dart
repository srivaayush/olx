import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:olx/authenti/google_auth.dart';
import 'package:olx/authenti/phone_auth.dart';
import 'package:olx/screens/otp_screen.dart';
import 'package:olx/screens/home_screen.dart';

class auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new phoneauthscreen()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_android_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text('Continue with Phone'),
                  ],
                )),
          ),
          SignInButton(Buttons.Google, text: "Sign in with Google",
              onPressed: () async {
            User? user = await GoogleAuth.signInWithGoogle(context: context);

            print(
                'usssssssssssssssssssssssssssssssssssssssssssssssssssssssssssserrrrrrrrrrr $user');

            if (user != null) {
              print('googlee successfulll');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => home_screen()));
              // OTPScreen();
            } else {
              print('Ram');
            }
            //signInWithGoogle(context);
          }),
          SignInButton(Buttons.FacebookNew, text: "Sign in with Facebook",
              onPressed: () {
            print("ram");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => home_screen()));
          }),
        ],
      ),
    );
  }
}
