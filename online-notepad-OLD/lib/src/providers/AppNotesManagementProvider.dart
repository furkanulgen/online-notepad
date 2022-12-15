import 'package:flutter/material.dart';
import '../pages/home_page/homepages/UserPage.dart';
import '../pages/home_page/homepages/AnaSayfa.dart';

class AppNotesManagementProvider with ChangeNotifier {
  int noteCount = 0;
  TextEditingController note1 = TextEditingController();
  TextEditingController note2 = TextEditingController();
  TextEditingController note3 = TextEditingController();
  TextEditingController note4 = TextEditingController();
  TextEditingController note5 = TextEditingController();
  TextEditingController note6 = TextEditingController();
  
  List<String> notes = ['', '', '', '', '', ''];

  setNoteCount(int _i) {
    noteCount = _i;
    notifyListeners();
  }
  setNotesText(String n1,String n2,String n3,String n4,String n5,String n6,) {
    note1.text = n1;
    note2.text = n2;
    note3.text = n3;
    note4.text = n4;
    note5.text = n5;
    note6.text = n6;
    notifyListeners();
  }
  List get getNotesText => [note1,note2,note3,note4,note5,note6];

  int get getNoteCount => noteCount;
}
