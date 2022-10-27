import 'package:flutter/material.dart';
import 'package:note_pad_v2/src/providers/AppPagesManagementProvider.dart';
import 'package:provider/provider.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    var _controlAPMP = Provider.of<AppPagesManagementProvider>(context);
    return Scaffold(body: (_controlAPMP.getPages)[_controlAPMP.getPageCount]);
  }
}