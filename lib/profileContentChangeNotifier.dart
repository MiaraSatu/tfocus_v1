import 'package:flutter/foundation.dart';

class ProfileContentChangeNotifier with ChangeNotifier {
  static List items = ["All", "Publications", "Articles", "Share"];
  String item = "All";

  String get currentItem => item;

  set currentItem(String item) {
    if(item != this.item) {
      if(item == "All" || item == "Publications" || item == "Articles" || item == "Share") {
        this.item = item;
      }
      else {
        this.item = "All";
      }
      notifyListeners();
    }
  }
}