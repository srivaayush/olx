import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Image.asset('assets/images/cart.png',),
              SizedBox(height:10,),
              Center(
                child: Text('Loading...'),
              )
            ]
        ),
      ),
    );
  }
}

