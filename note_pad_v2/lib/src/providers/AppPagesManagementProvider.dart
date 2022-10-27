import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/home_page/homepages/UserPage.dart';
import '../pages/home_page/homepages/AnaSayfa.dart';

class AppPagesManagementProvider with ChangeNotifier{
  int pageCount = 0;
  List<Widget> pages = [
    AnaSayfa(),
    KullaniciSayfa(),
  ];
  setPageCount(int _i){
    pageCount = _i;
    notifyListeners();
  }
  
  int get getPageCount => pageCount;

  get getPages => pages;
}