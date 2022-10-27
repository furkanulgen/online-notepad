import 'package:flutter/material.dart';
import 'package:note_pad_v2/settings.dart';
import 'package:provider/provider.dart';
import '../../providers/AppLoginProvider.dart';
import '../../providers/AppPagesManagementProvider.dart';
import '../../providers/AppNotesManagementProvider.dart';
import 'package:mysql1/mysql1.dart';

TextEditingController usernameTextBox = TextEditingController();
TextEditingController passwordTextBox = TextEditingController();

class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _controlALP = Provider.of<AppLoginProvider>(context);
    var _controlAPMP = Provider.of<AppPagesManagementProvider>(context);
    var _controlANMP = Provider.of<AppNotesManagementProvider>(context);
    return Scaffold(
      backgroundColor: page4Color,
      body: SafeArea(
          child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("H E L L O",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          SizedBox(
            height: 10,
          ),
          Text("Welcome to OnlineNotePadV2", style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 20.0,
          ),
          //mail
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: page3Color),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: usernameTextBox,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "USERNAME"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: page3Color),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: passwordTextBox,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "PASSWORD"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Sign İn
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: page3Color, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Column(
                  children: [
                    //Giriş Buttonu
                    ElevatedButton(
                      onPressed: () async {
                        var dbConnection = ConnectionSettings(
                            host: dbHost,
                            port: dbPort,
                            user: dbUser,
                            password: dbPassword,
                            db: dbName);

                        var conn = await MySqlConnection.connect(dbConnection);
                        var sql =
                            "Select * From users Where _un = '${usernameTextBox.text}' and _pw = '${passwordTextBox.text}';";
                        var resultsLogin = await conn.query(sql);
                        print(resultsLogin);
                        if (resultsLogin
                                .toString()
                                .contains('_un: ${usernameTextBox.text}') &&
                            resultsLogin
                                .toString()
                                .contains('_pw: ${passwordTextBox.text}}')) {
                          print("Kullanıcı Bulundu Giriş Başarılı");
                          _controlALP.setLoginStatus(true);
                          _controlALP.setUserName("${usernameTextBox.text}");
                          var Nsql =
                              "Select _note1, _note2, _note3, _note4, _note5, _note6 from notes Where _un = '${_controlALP.getUserName}';";
                          var resultsNote = await conn.query(Nsql);
                          for (var row in resultsNote) {
                            _controlANMP.setNotesText(
                                row[0].toString(),
                                row[1].toString(),
                                row[2].toString(),
                                row[3].toString(),
                                row[4].toString(),
                                row[5].toString());
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Wrong Information"),
                          ));
                          _controlALP.setLoginStatus(false);
                          _controlANMP.setNoteCount(0);
                        }
                        await conn.close();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Sign In"),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color?>(page2Color),
                      ),
                    ),
                    //Kayıt Buttonu
                    ElevatedButton(
                      onPressed: () async {
                        if (usernameTextBox.text != "" &&
                            passwordTextBox.text != "" &&
                            passwordTextBox.text.length + 1 > 6 &&
                            usernameTextBox.text.length + 1 > 6) {
                          var dbConnection = ConnectionSettings(
                              host: dbHost,
                              port: dbPort,
                              user: dbUser,
                              password: dbPassword,
                              db: dbName);

                          var conn =
                              await MySqlConnection.connect(dbConnection);

                          var results = await conn.query(
                              "Insert Into users(_un,_pw) Values('${usernameTextBox.text}','${passwordTextBox.text}');");
                          if (results.toString() == "()") {
                            _controlALP.setUserName(usernameTextBox.text);
                            _controlALP.setLoginStatus(true);
                            var NotesDBresults = conn.query(
                                "Insert Into notes(_un) Values('${usernameTextBox.text}');");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("This username is in use."),
                            ));
                          }
                          await conn.close();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("at least 6 characters"),
                          ));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.app_registration),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Register")
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color?>(page2Color),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text("Developer Furkan Ulgen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ]),
      )),
    );
  }
}
