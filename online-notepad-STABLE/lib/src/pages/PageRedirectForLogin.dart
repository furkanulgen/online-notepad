// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginWithout/LoginPage.dart';
import 'LoginIn/PageRedirectForPageManegement.dart';

class PageRedirectForLogin extends StatelessWidget {
  const PageRedirectForLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Test Page',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PageRedirectForPageManagement();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}