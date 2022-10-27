import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './src/pages/main_page.dart';
import './src/providers/AppLoginProvider.dart';
import './src/providers/AppPagesManagementProvider.dart';
import './src/providers/AppNotesManagementProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppLoginProvider>(
          create: (BuildContext context) => AppLoginProvider()),
      ChangeNotifierProvider<AppPagesManagementProvider>(
          create: (BuildContext context) => AppPagesManagementProvider()),
          ChangeNotifierProvider<AppNotesManagementProvider>(
          create: (BuildContext context) => AppNotesManagementProvider()),
    ],
    child: MaterialApp(
      home: MyScaffold(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
