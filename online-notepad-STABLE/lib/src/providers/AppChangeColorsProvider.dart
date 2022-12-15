import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';

class AppChangeColorsProvider with ChangeNotifier {
  Map<String, dynamic> colorsIndex = colorPackage2;
  
  List<Map<String, dynamic>> colors = [
    colorPackage1,
    colorPackage2,
    colorPackage3,
  ];
  
  setColorsIndex(index){
    colorsIndex = colors[index];
    notifyListeners();
  }

  Map<String, dynamic> get getColorsMap => colorsIndex;
}