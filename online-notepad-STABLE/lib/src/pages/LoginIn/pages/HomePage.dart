import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_notepad/src/pages/LoginIn/pages/ShowPage.dart';
import 'package:online_notepad/src/providers/AppPageManagementProvider.dart';
import 'package:online_notepad/src/providers/AppChangeLanguageProvider.dart';
import '../../../providers/AppChangeColorsProvider.dart';
import '../../../settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    var renkler = Provider.of<AppChangeColorsProvider>(context).getColorsMap;
    var _controlAPMP = Provider.of<AppPageManagementProvider>(context);
    var _controlACLP = Provider.of<AppChangeLanguageProvider>(context);
    Map language = _controlACLP.getLanguageMap;
    language = _controlACLP.getLanguageMap;
    final user = FirebaseAuth.instance.currentUser!;
    Stream noteDocumentStream = FirebaseFirestore.instance
        .collection('user')
        .doc('${user.uid}')
        .collection('notes')
        .snapshots();
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
                          "${language['HP_PageTitle']}",
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
          Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: renkler['page3color'],
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        side: MaterialStatePropertyAll(BorderSide.none)),
                    onPressed: () {
                      _controlAPMP.setPageCount(1);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundImage: NetworkImage("${user.photoURL}")),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${language['HP_hellobar']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            Text(
                              "${user.displayName}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: renkler['page1color'],
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder(
                      stream: noteDocumentStream,
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data.docs;
                          if (documents.length != 0) {
                            return ListView.builder(
                                itemCount: documents.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Slidable(
                                      key: const ValueKey(1),
                                      startActionPane: ActionPane(
                                        motion: ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            borderRadius: BorderRadius.circular(8),
                                            onPressed: (_) async {
                                              var collection = await FirebaseFirestore
                                            .instance
                                            .collection('user')
                                            .doc('${user.uid}')
                                            .collection('notes')
                                            .doc("${documents[index].id}")
                                            .delete();
                                            },
                                            backgroundColor: Color(0xFFFE4A49),
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: '${language['HP_strDelete']}',
                                          ),
                                          SlidableAction(
                                            borderRadius: BorderRadius.circular(8),
                                            onPressed: (_) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowNotePage(
                                                            id: "${documents[index].id}",
                                                            title:
                                                                "${documents[index].get('title')}",
                                                            note:
                                                                "${documents[index].get('note')}",
                                                            date:
                                                                "${documents[index].get('createAtDate')} ${documents[index].get('createAtHour')}",
                                                          )));
                                            },
                                            backgroundColor: Color(0xFFf1e132),
                                            foregroundColor: Colors.white,
                                            icon: FontAwesomeIcons.pencil,
                                            label: '${language['HP_strEdit']}',
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: renkler['page4color']),
                                        child: ListTile(
                                          onTap: (() {
                                            //TODO
                                          }),
                                          leading: Text(
                                            "#${index + 1}",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          title: Text(
                                              "${documents[index].get('title')}"),
                                          subtitle: Text(
                                              "\n${documents[index].get('createAtDate')} / ${documents[index].get('createAtHour')}"),
                                          trailing:
                                              Column(
                                                children: [
                                                  Text("${language['HP_strLeftToRight']}"),
                                                  Icon(FontAwesomeIcons.arrowRight),
                                                ],
                                              ),
                                        ),
                                      ),
                                    ),
                                  );
                                  /*return Text("${documents[index].get('name')}");*/
                                  // return Card(
                                  //   elevation: 0,
                                  //   shape: RoundedRectangleBorder(
                                  //     side: BorderSide(
                                  //       color: Theme.of(context)
                                  //           .colorScheme
                                  //           .outline,
                                  //     ),
                                  //     borderRadius: const BorderRadius.all(
                                  //         Radius.circular(12)),
                                  //   ),
                                  //   child: SizedBox(
                                  //     width: 300,
                                  //     height: 100,
                                  //     child: OutlinedButton(
                                  //       onPressed: () {},
                                  //       child: Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         children: [
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.end,
                                  //             children: [
                                  //               Text("#${index + 1}"),
                                  //             ],
                                  //           ),
                                  //           Divider(color: Colors.black),
                                  //           Expanded(
                                  //               child: Center(
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceBetween,
                                  //               children: [
                                  //                 Column(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment.start,
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment
                                  //                           .start,
                                  //                   children: [
                                  //                     Text(
                                  //                       "TITLE ;",
                                  //                       style: TextStyle(
                                  //                           fontSize: 12),
                                  //                     ),
                                  //                     Text(
                                  //                       "${documents[index].get('title')}",
                                  //                       overflow:
                                  //                           TextOverflow.fade,
                                  //                       maxLines: 1,
                                  //                       softWrap: false,
                                  //                       style: TextStyle(
                                  //                         fontSize: 24,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //                 Divider(),
                                  //                 Column(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment.start,
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment
                                  //                           .start,
                                  //                   children: [
                                  //                     Text(
                                  //                       "DATE ;",
                                  //                       style: TextStyle(
                                  //                           fontSize: 12),
                                  //                     ),
                                  //                     Text(
                                  //                       "\n${documents[index].get('createAtDate')} \n${documents[index].get('createAtHour')}",
                                  //                       style: TextStyle(
                                  //                           fontSize: 12),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           )),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // );
                                }));
                          } else {
                            return Text("${language['HP_STRnonstream']}");
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return Text("${language['HP_STRnonstream']}");
                        }
                      }),
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
