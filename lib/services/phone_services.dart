import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx/screens/otp_screen.dart';

class phoneauthservices{
  FirebaseAuth auth=FirebaseAuth.instance;

  Future<void>verifyPhoneNumber(BuildContext context,number)async {
    final PhoneVerificationCompleted verificationCompleted = (
        PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };
    final PhoneVerificationFailed verificationFailed = (
        FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('Phone number is not valid');
      }
      print('The error is ${e.code}');
    };
    final PhoneCodeSent codeSent=(String verId,int resendToken)async{
      Navigator.push(context,MaterialPageRoute(builder: (context)=>OTPScreen()));
    } as PhoneCodeSent;
    try{
      auth.verifyPhoneNumber(phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed, codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId){
           print(verificationId);
          });
    }
    catch(e){
      print('Error ${e.toString()}');
    }
  }
}