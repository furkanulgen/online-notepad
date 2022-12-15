import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/LoginIn/pages/HomePage.dart';
import '../pages/LoginIn/pages/UserPage.dart';

class AppPageManagementProvider with ChangeNotifier {
  int pageCount = 1;
  List<Widget> pages = [
    HomePage(),
    UserPage(),
  ]; 

  setPageCount(count){
    pageCount = count;
    notifyListeners();
  }

  int get getPageCount => pageCount; 
  List<Widget> get getPages => pages; 
}

