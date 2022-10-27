import 'package:flutter/material.dart';
import 'package:note_pad_v2/src/providers/AppLoginProvider.dart';
import '../../../providers/AppPagesManagementProvider.dart';
import '../../../providers/AppNotesManagementProvider.dart';
import 'package:provider/provider.dart';
import '../../../../settings.dart';
import 'package:mysql1/mysql1.dart';

List<String> notesControl = [
  "Note 1",
  "Note 2",
  "Note 3",
  "Note 4",
  "Note 5",
  "Note 6"
];

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    var _controlAPMP = Provider.of<AppPagesManagementProvider>(context);
    var _controlANMP = Provider.of<AppNotesManagementProvider>(context);
    var _controlALP = Provider.of<AppLoginProvider>(context);

    return Scaffold(
      backgroundColor: page3Color,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "OnlineNotePadV2",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                ElevatedButton(onPressed: (){_controlAPMP.setPageCount(1);}, child: Icon(Icons.person),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(page2Color)),)
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: page4Color, borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                _controlANMP.setNoteCount(0);
                              },
                              child: Text("Note 1"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(page2Color)),
                            ),
                            width: 90,
                            height: 90,
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                _controlANMP.setNoteCount(1);
                              },
                              child: Text("Note 2"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(page2Color)),
                            ),
                            width: 90,
                            height: 90,
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                _controlANMP.setNoteCount(2);
                              },
                              child: Text("Note 3"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(page2Color)),
                            ),
                            width: 90,
                            height: 90,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                _controlANMP.setNoteCount(3);
                              },
                              child: Text("Note 4"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(page2Color)),
                            ),
                            width: 90,
                            height: 90,
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                _controlANMP.setNoteCount(4);
                              },
                              child: Text("Note 5"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(page2Color)),
                            ),
                            width: 90,
                            height: 90,
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                _controlANMP.setNoteCount(5);
                              },
                              child: Text("Note 6"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(page2Color)),
                            ),
                            width: 90,
                            height: 90,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: page4Color),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Text(
                                        "${notesControl[_controlANMP.getNoteCount]}",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: page4Color),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _controlANMP
                                                      .getNotesText[
                                                  _controlANMP.getNoteCount],
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "NOTE IS HERE"),
                                              minLines: 20,
                                              maxLines: 21,
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
                                      color: page4Color),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          var dbConnection = ConnectionSettings(
                                              host: dbHost,
                                              port: dbPort,
                                              user: dbUser,
                                              password: dbPassword,
                                              db: dbName);
                                          var conn =
                                              await MySqlConnection.connect(
                                                  dbConnection);

                                          var Nsql =
                                              "Select _note1, _note2, _note3, _note4, _note5, _note6 from notes Where _un = '${_controlALP.getUserName}';";
                                          var resultsNoteT =
                                              await conn.query(Nsql);
                                          for (var row in resultsNoteT) {
                                            _controlANMP.setNotesText(
                                                row[0].toString(),
                                                row[1].toString(),
                                                row[2].toString(),
                                                row[3].toString(),
                                                row[4].toString(),
                                                row[5].toString());
                                          }
                                        },
                                        icon: Icon(Icons.refresh),
                                        label: Text("Refresh All"),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    page2Color)),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          var dbConnection = ConnectionSettings(
                                              host: dbHost,
                                              port: dbPort,
                                              user: dbUser,
                                              password: dbPassword,
                                              db: dbName);

                                          var updateNotSql =
                                              "UPDATE notes SET _note${_controlANMP.getNoteCount + 1} = '${_controlANMP.getNotesText[_controlANMP.getNoteCount].text}' WHERE _un = '${_controlALP.getUserName}';";

                                          var conn =
                                              await MySqlConnection.connect(
                                                  dbConnection);

                                          var results =
                                              await conn.query(updateNotSql);
                                        },
                                        icon: Icon(Icons.save),
                                        label: Text("Save"),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    page2Color)),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          var dbConnection = ConnectionSettings(
                                              host: dbHost,
                                              port: dbPort,
                                              user: dbUser,
                                              password: dbPassword,
                                              db: dbName);

                                          var updateNotSql =
                                              "UPDATE notes SET _note1 = '${_controlANMP.getNotesText[1].text}' and _note1 = '${_controlANMP.getNotesText[1].text}' and _note1 = '${_controlANMP.getNotesText[1].text}' and _note1 = '${_controlANMP.getNotesText[1].text}' and _note1 = '${_controlANMP.getNotesText[1].text}' and  WHERE _un = '${_controlALP.getUserName}';";

                                          var conn =
                                              await MySqlConnection.connect(
                                                  dbConnection);

                                          var results =
                                              await conn.query(updateNotSql);
                                        },
                                        icon: Icon(Icons.save),
                                        label: Text("Save All"),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    page2Color)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: page2Color,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
