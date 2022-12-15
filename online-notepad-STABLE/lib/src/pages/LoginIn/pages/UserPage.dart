import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../language.dart';
import '../../../providers/AppChangeColorsProvider.dart';
import '../../../providers/AppGoogleLoginProvider.dart';
import '../../../providers/AppChangeLanguageProvider.dart';
import '../../../settings.dart';

bool defaultTheme = false;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var renkler = Provider.of<AppChangeColorsProvider>(context).getColorsMap;
    var _controlACCP = Provider.of<AppChangeColorsProvider>(context);
    var _controlACLP = Provider.of<AppChangeLanguageProvider>(context);
    Map language = _controlACLP.getLanguageMap;
    var controlALP = Provider.of<AppGoogleLoginProvider>(context);
    final user = FirebaseAuth.instance.currentUser!;
    var test = FirebaseFirestore.instance
        .collection('user')
        .doc('${user.uid}')
        .collection('notes')
        .get();
    return SafeArea(
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: renkler['page1color']),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "${language['UP_PageTitle']}",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: renkler['page4color']),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: renkler['page1color']),
                        child: Center(
                            child: Text(
                                "${DateTime.now().hour >= 5 && DateTime.now().hour < 12 ? "${language['UP_strGM']}" : DateTime.now().hour >= 12 && DateTime.now().hour < 17 ? "${language['UP_strGA']}" : "${language['UP_strGE']}"}",
                                style: TextStyle(
                                    fontSize: 26, color: renkler['page4color']))))),
                SizedBox(width: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        controlALP.GoogleLogOut();
                      },
                      icon: FaIcon(FontAwesomeIcons.rightFromBracket),
                      label: Text("${language['UP_BTNlogout']}"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          foregroundColor: renkler['page4ForButton'],
                          shadowColor: ghostColorForButton),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: renkler['page1color'], borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage("${user.photoURL}"))),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: renkler['page4color']),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                            '${user.displayName}',
                                            style: TextStyle(fontSize: 26),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: renkler['page4color']),
                              child: Center(
                                  child: Text('${user.email}',
                                      style: TextStyle(fontSize: 26))),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: renkler['page4color']),
                              child: Center(
                                  child: Text('${language['UP_strPlan']} : FREE',
                                      style: TextStyle(fontSize: 26))),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: renkler['page2color'],
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Text("${language['UP_strChangePlan']}",
                                    style: TextStyle(
                                        fontSize: 26, color: renkler['page4color'])),
                                SizedBox(
                                  height: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: renkler['page3color'],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      renkler['page2ForButton']),
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "${language['UP_P1title']}",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Divider(color: Colors.black),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "${language['UP_P1details1']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      Text(
                                                          "${language['UP_P1details2']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          "${language['UP_P1footer']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: renkler['page3color'],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      renkler['page2ForButton']),
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "${language['UP_P2title']}",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Divider(color: Colors.black),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "${language['UP_P2details1']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      Text(
                                                          "${language['UP_P2details2']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          "${language['UP_P234footer']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: renkler['page3color'],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      renkler['page2ForButton']),
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "${language['UP_P3title']}",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Divider(color: Colors.black),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "${language['UP_P3details1']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      Text(
                                                          "${language['UP_P3details2']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          "${language['UP_P234footer']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: renkler['page3color'],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      renkler['page2ForButton']),
                                              onPressed: () {},
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "${language['UP_P4title']}",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Divider(color: Colors.black),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "${language['UP_P4details1']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      Text(
                                                          "${language['UP_P4details2']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          "${language['UP_P234footer']}",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                color: renkler['page2color'],
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Text("${language['UP_strChangeLanguage']}",
                                    style: TextStyle(
                                        fontSize: 26, color: renkler['page4color'])),
                                SizedBox(
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: renkler['page3color'],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      renkler['page2ForButton']),
                                              onPressed: () {
                                                _controlACLP.setLanguageIndex(1);
                                              },
                                              child: Center(
                                                child: Text("TÜRKÇE",
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: renkler['page3color'],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      renkler['page2ForButton']),
                                              onPressed: () {
                                                _controlACLP.setLanguageIndex(0);
                                              },
                                              child: Center(
                                                child: Text("ENGLISH",
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: renkler['page3color'],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      renkler['page2ForButton']),
                                              onPressed: () {
                                                _controlACLP.setLanguageIndex(2);
                                              },
                                              child: Center(
                                                child: Text("GERMAN",
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: renkler['page3color'],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      renkler['page2ForButton']),
                                              onPressed: () {
                                                _controlACLP.setLanguageIndex(3);
                                              },
                                              child: Text("RUSSIAN",
                                                  style: TextStyle(fontSize: 12)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: renkler['page2color'],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text('${language['UP_btnCT']}',style: TextStyle(
                                        fontSize: 24, color: renkler['page4color'])),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(onPressed: (){
                                  _controlACCP.setColorsIndex(1);
                                }, child: Text('${language['UP_btnBlc']}',style: TextStyle(color: renkler['page1color']))),
                                OutlinedButton(onPressed: (){
                                  _controlACCP.setColorsIndex(0);
                                }, child: Text('${language['UP_btnLig']}',style: TextStyle(color: renkler['page1color']),)),
                              ],
                            )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
