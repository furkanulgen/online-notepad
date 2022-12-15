import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../providers/AppChangeColorsProvider.dart';
import '../../../providers/AppPageManagementProvider.dart';
import '../../../providers/AppChangeLanguageProvider.dart';

import '../../../settings.dart';

TextEditingController noteFieldS = TextEditingController();
TextEditingController titleFieldS = TextEditingController();

class ShowNotePage extends StatelessWidget {
  const ShowNotePage({
    super.key,
    required this.id,
    required this.title,
    required this.note,
    required this.date,
  });
  final id;
  final title;
  final note;
  final date;

  @override
  Widget build(BuildContext context) {
    var renkler = Provider.of<AppChangeColorsProvider>(context).getColorsMap;
    var _controlACLP = Provider.of<AppChangeLanguageProvider>(context);
    Map language = _controlACLP.getLanguageMap;
    titleFieldS.text = title;
    noteFieldS.text = note;
    final user = FirebaseAuth.instance.currentUser;
    var _controlAPMP = Provider.of<AppPageManagementProvider>(context);
    return Scaffold(
      backgroundColor: renkler['page4color'],
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: renkler['page1color']),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '${language['SNP_PageTitle']}',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: renkler['page4color']),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        centerTitle: true,
        shadowColor: ghostColor,
        backgroundColor: renkler['page4color'],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                          '${language['SNP_PageTitle']}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: renkler['page4color'],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        // ignore: sort_child_properties_last
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: renkler['page4color']),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextField(
                                      maxLength: 16,
                                      minLines: 1,
                                      maxLines: 1,
                                      controller: titleFieldS,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "${language['SNP_strTitle']}"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: renkler['page4color']),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              maxLength: 1024,
                                              controller: noteFieldS,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      "${language['SNP_strNote']}"),
                                              minLines: 98,
                                              maxLines: 99,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: renkler['page4color']),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        Map<String, dynamic> updateJson = {
                                          'title': '${titleFieldS.text}',
                                          'note': '${noteFieldS.text}',
                                          'createAtDate':
                                              '${DateTime.now().toString().substring(0, 10)}',
                                          'createAtHour':
                                              '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
                                        };
                                        var collection = await FirebaseFirestore
                                            .instance
                                            .collection('user')
                                            .doc('${user!.uid}')
                                            .collection('notes')
                                            .doc(id)
                                            .update(updateJson);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              '${language['SNP_ALERTsneakbar']}'),
                                        ));
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.save),
                                      label: Text('${language['SNP_BTNsave']}'),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              renkler['page4ForButton'],
                                          backgroundColor:
                                              renkler['page2ForButton']),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: renkler['page1color'],
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
