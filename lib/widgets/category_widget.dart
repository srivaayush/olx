import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:olx/form/cat_provider.dart';
import 'package:provider/provider.dart';

class category_widgit extends StatelessWidget {
  const category_widgit({Key? key}) : super(key: key);

  Future<List<QueryDocumentSnapshot<Object?>>> getCategories() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("categories").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseService _services=FirebaseService();

    var _catProvider = Provider.of<CategoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: FutureBuilder<dynamic>(
        future: getCategories(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return Container(
              child: Text("Loading"),
            );
          } else {
            return Container(
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Categories')),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text('See all',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ],
                          )),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // print(snapshot.data.runtimeType),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data[index];
                      print(snapshot.data[index]['image']);
                      _catProvider.getCategory(doc['catName']);
                      _catProvider.getSnapshot(doc);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 60,
                            height: 50,
                            child: Column(
                              children: [
                                Image.network(doc['image']),
                                Text(doc['catName']),
                              ],
                            )),
                      );
                    },
                  ))
                ],
              ),
            );
          }
        },
      )),
    );
  }
}

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
}
