import 'package:flutter/material.dart';
import 'package:note_pad_v2/src/providers/AppNotesManagementProvider.dart';
import '../../../providers/AppPagesManagementProvider.dart';
import '../../../providers/AppLoginProvider.dart';
import 'package:provider/provider.dart';
import '../../../../settings.dart';

List<NetworkImage> dateIcon = [
  NetworkImage(
      "https://www.iconpacks.net/icons/2/free-sun-icon-3337-thumb.png"),
  NetworkImage("https://cdn-icons-png.flaticon.com/512/430/430485.png"),
  NetworkImage(
      "https://thumbs.dreamstime.com/z/night-icon-vector-isolated-white-background-night-sign-lin-night-icon-vector-isolated-white-background-night-transparent-133800227.jpg")
];
List<Text> dateText = [
  Text("Good Morning",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
  Text("Good Afternoon",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
  Text("Good Evening",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
];

class KullaniciSayfa extends StatelessWidget {
  const KullaniciSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    var _controlAPMP = Provider.of<AppPagesManagementProvider>(context);
    var _controlALP = Provider.of<AppLoginProvider>(context);
    var _controlANMP = Provider.of<AppNotesManagementProvider>(context);
    print(DateTime.now().hour);
    return Scaffold(
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
                ElevatedButton(
                  onPressed: () {
                    _controlAPMP.setPageCount(0);
                  },
                  child: Icon(Icons.home),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(page2Color)),
                )
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
                            child: Image(
                                image: DateTime.now().hour >= 5 &&
                                        DateTime.now().hour < 12
                                    ? dateIcon[0]
                                    : DateTime.now().hour >= 12 &&
                                            DateTime.now().hour < 18
                                        ? dateIcon[1]
                                        : dateIcon[2]),
                            width: 135,
                            height: 190,
                          ), //TODO 5>12 12>18 18>5
                          Container(
                            child: DateTime.now().hour < 12 &&
                                    DateTime.now().hour > 12
                                ? dateText[0]
                                : DateTime.now().hour < 18
                                    ? dateText[1]
                                    : dateText[2],
                            width: 135,
                            height: 190,
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
                                        "User Information",
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
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: page3Color),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                    child: Row(
                                                  children: [
                                                    Icon(Icons.person),
                                                    Text(
                                                      "Username : ${_controlALP.getUserName}",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: page3Color),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.person),
                                              ],
                                            ),
                                          ),
                                        ),

                                        //*
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
                                        onPressed: () {
                                          _controlALP.setLoginStatus(false);
                                          _controlALP.setUserName("");
                                          _controlANMP.setNotesText(
                                              '', '', '', '', '', '');
                                          _controlANMP.setNoteCount(0);
                                        },
                                        icon: Icon(Icons.logout),
                                        label: Text("Logout"),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    page2Color)),
                                      ),
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
