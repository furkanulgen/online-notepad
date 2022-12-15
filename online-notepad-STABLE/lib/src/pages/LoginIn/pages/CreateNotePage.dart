import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../providers/AppPageManagementProvider.dart';
import '../../../providers/AppChangeLanguageProvider.dart';
import '../../../providers/AppChangeColorsProvider.dart';
import '../../../settings.dart';

TextEditingController noteFieldC = TextEditingController();
TextEditingController titleFieldC = TextEditingController();

class CreateNotePage extends StatelessWidget {
  const CreateNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    var renkler = Provider.of<AppChangeColorsProvider>(context).getColorsMap;
    var _controlACLP = Provider.of<AppChangeLanguageProvider>(context);
    Map language = _controlACLP.getLanguageMap; 
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
                    borderRadius: BorderRadius.circular(12), color: renkler['page1color']),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "${language['CNP_PageTitle']}",
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
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: renkler['page4color']),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: TextField(
                                      maxLength: 16,
                                      controller: titleFieldC,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "${language['CNP_TextBoxTitle']}"),
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
                                          padding: const EdgeInsets.all(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: TextField(
                                              maxLength: 1024,
                                              controller: noteFieldC,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "${language['CNP_TextBoxNote']}"),
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
                                        var collection = await FirebaseFirestore
                                            .instance
                                            .collection('user')
                                            .doc('${user!.uid}')
                                            .collection('notes')
                                            .get();
                                        var noteCount =
                                            await collection.docs.length;
                                        if (noteCount <= 5) {
                                          //* CREATE NOTE
                                          if(titleFieldC.text.isEmpty) titleFieldC.text = "${language['CNP_STRnewnote']}";
                                          if(noteFieldC.text.isEmpty) noteFieldC.text = "${language['CNP_STRnewnote']}";
                                          Map<String, dynamic> noteJson = {
                                            'title': '${titleFieldC.text}',
                                            'note': '${noteFieldC.text}',
                                            'createAtDate':
                                                '${DateTime.now().toString().substring(0, 10)}',
                                            'createAtHour':
                                                '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
                                          };
                                          await FirebaseFirestore.instance
                                              .collection('user')
                                              .doc('${user.uid}')
                                              .collection('notes')
                                              .add(noteJson);
                                              titleFieldC.text = "";
                                              noteFieldC.text = "";
                                          Navigator.pop(context);
                                        } else {
                                          //* SNEAK BAR SHOW
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                '${language['CNP_ALERTsneakbar']}'),
                                          ));
                                        }
                                      },
                                      icon: Icon(Icons.save),
                                      label: Text("${language['CNP_BTNcreateNewNote']}"),
                                      style: ButtonStyle(
                                          foregroundColor: renkler['page4ForButton'],
                                          backgroundColor: renkler['page2ForButton']),
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
