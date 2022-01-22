import 'package:flutter/material.dart';
import 'package:olx/widgets/banner.dart';
import 'package:olx/widgets/category_widget.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);
  static const String id = 'home-screen';
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      labelText: 'Search here',
                      labelStyle: TextStyle(fontSize: 20),
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Column(
              children: [
                banner(),
                category_widgit(),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
