import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:olx/form/cat_provider.dart';
import 'package:provider/provider.dart';

class UserReviewScreen extends StatefulWidget {
  const UserReviewScreen({Key? key}) : super(key: key);
  static const String id = 'user-review-screen';
  static final _formkey = GlobalKey<FormState>();

  @override
  _UserReviewScreenState createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  var _nameController = TextEditingController();
  var _countryController = TextEditingController(text: '+91');
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _addressController = TextEditingController();

  @override
  void didChangeDependencies() {
    var _provider = Provider.of<CategoryProvider>(context);
    _provider.getuserDetails();
    setState(() {
      _nameController = _provider.userDetails.data().toString().contains('name')
          ? _provider.userDetails['name']
          : '';
      _countryController =
          _provider.userDetails.data().toString().contains('country')
              ? _provider.userDetails['country']
              : '';
      _phoneController =
          _provider.userDetails.data().toString().contains('phone')
              ? _provider.userDetails['phone']
              : '';
      _emailController =
          _provider.userDetails.data().toString().contains('email')
              ? _provider.userDetails['email']
              : '';
      _addressController =
          _provider.userDetails.data().toString().contains('address')
              ? _provider.userDetails['address']
              : '';
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Review your details",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: Colors.black),
          shape: Border(
            bottom: BorderSide(
                color: Colors.grey.shade400, style: BorderStyle.solid),
          )),
      body: Form(
        key: UserReviewScreen._formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent.shade400,
                    radius: 40,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueGrey.shade500,
                      radius: 38,
                      child: Icon(
                        CupertinoIcons.person_alt,
                        size: 60,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: _nameController,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter your name';

                      return null;
                    },
                  ))
                ],
              ),
              SizedBox(height: 30),
              Text("Contact details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _countryController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Country code',
                          helperText: '', //just to align numbering
                        ),
                      )),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Mobile number',
                      ),
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter Mobile number';
                        if (value.length < 10)
                          return 'Enter correct Mobile number';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  final bool isvalid = EmailValidator.validate(_emailController
                      .text); // import 'package:email_validator/email_validator.dart';
                  if (value == null || value.isEmpty) {
                    return 'Enter Email';
                  }
                  if (value.isNotEmpty && isvalid == false)
                    return 'Enter valid Email';
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Address',
                  counterText: 'Your address with pincode',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Fill required fields';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
