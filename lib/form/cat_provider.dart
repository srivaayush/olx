import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CategoryProvider extends ChangeNotifier {
  late DocumentSnapshot doc;
  late String SelectedCategory;
  List<String> urlList = [];

  getCategory(selectedCat) {
    this.SelectedCategory = selectedCat;
    notifyListeners();
  }

  getSnapshot(snapshot) {
    this.doc = snapshot;
    notifyListeners();
  }

  getImages(url) {
    this.urlList.add(url);
    notifyListeners();
  }
}
