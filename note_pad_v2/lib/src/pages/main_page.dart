import 'package:flutter/material.dart';
import './login_page/login_page.dart';
import './home_page/home_page.dart';
import 'package:provider/provider.dart';
import '../providers/AppLoginProvider.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var _controlALP = Provider.of<AppLoginProvider>(context);

    return Scaffold(
      body: _controlALP.getLoginStatus == true ? homePage() : loginPage(),
    );
  }
}
