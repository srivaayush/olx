import 'package:flutter/material.dart';
import 'package:olx/widgets/auth_page.dart';

class login extends StatefulWidget {
  static const String id = 'login-screen';
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/cart.png',
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text('OLX Clone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                )
              ],
            )),
            Expanded(
              child: Container(
                child: auth(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
