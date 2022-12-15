import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/LoginIn/pages/HomePage.dart';
import '../pages/LoginIn/pages/UserPage.dart';
import '../language.dart';

class AppChangeLanguageProvider with ChangeNotifier {
  Map<String, String> languageIndex = turkish;
  List<Map<String, String>> languages = [
    english,
    turkish,
    german,
    russain,
  ];
  
  setLanguageIndex(index){
    languageIndex = languages[index];
    notifyListeners();
  }

  Map<String, String> get getLanguageMap => languageIndex;
}

