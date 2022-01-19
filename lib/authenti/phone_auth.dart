import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx/screens/otp_screen.dart';
import 'package:olx/services/phone_services.dart';

class phoneauthscreen extends StatefulWidget {
  static const String id = 'phone-auth-screen';
  @override
  _phoneauthscreenState createState() => _phoneauthscreenState();
}

class _phoneauthscreenState extends State<phoneauthscreen> {
  bool valid = false;
  @override
  var countrycodeController = TextEditingController(text: '+91');
  var phoneController = TextEditingController();
  phoneauthservices _service = phoneauthservices();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black12,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.black,
                size: 60,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Enter your Phone',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(
              height: 15,
            ),
            Text('We will send otp to your phone',
                style: TextStyle(fontSize: 15, color: Colors.black54)),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: countrycodeController,
                      decoration: InputDecoration(
                        labelText: 'Country',
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 8,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 10) {
                          setState(() {
                            valid = true;
                          });
                        } else {
                          setState(() {
                            valid = false;
                          });
                        }
                      },
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your Phone Number',
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: valid == true
                      ? MaterialStateProperty.all(Colors.blue)
                      : MaterialStateProperty.all(Colors.grey),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => OTPScreen(),
                  //   ),
                  // );
                  String number =
                      '${countrycodeController.text}${phoneController.text}';
                  _service.verifyPhoneNumber(context, number);
                  OTPScreen();
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ))),
    );
  }
}
