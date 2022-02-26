import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> addUser(uid) async {
    return users.doc(user!.uid).set({
      'uid': user!.uid,
      'name': Null,
      'mobile': user!.phoneNumber,
      'email': user!.email,
    }).catchError((error) => print("Failed to add user :$error"));
  }

  Future<void> updateUser(Map<String, dynamic> data, context) async {
    return users.doc(user!.uid).update(data).then(
      (value) {
        print('Successfully updated');
      },
    ).catchError((error) {
      print("There was an error updating profile");
    });
  }

  Future<DocumentSnapshot> getUserData() async {
    DocumentSnapshot doc = await users.doc(user!.uid).get();
    return doc;
  }
}
