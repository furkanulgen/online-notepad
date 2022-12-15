import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:online_notepad/src/pages/LoginIn/pages/CreateNotePage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../providers/AppChangeColorsProvider.dart';
import '../../providers/AppPageManagementProvider.dart';
import '../../providers/AppChangeLanguageProvider.dart';
import '../../settings.dart';

class PageRedirectForPageManagement extends StatelessWidget {
  const PageRedirectForPageManagement({super.key});
  @override
  Widget build(BuildContext context) {
    var renkler = Provider.of<AppChangeColorsProvider>(context).getColorsMap;
    var _controlACLP = Provider.of<AppChangeLanguageProvider>(context);
    Map language = _controlACLP.getLanguageMap; 
    var _controlAPMP = Provider.of<AppPageManagementProvider>(context);
    return Scaffold(
      body: _controlAPMP.getPages[_controlAPMP.getPageCount],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          rippleColor: renkler['page2color'],
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: renkler['page1color'],
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: renkler['page2color'],
          color: renkler['page1color'],
          tabs: [
            GButton(
              icon: FontAwesomeIcons.addressCard,
              text: '${language['S_NP']}',
            ),
            GButton(
              icon: FontAwesomeIcons.earthAmericas,
              text: '${language['S_UP']}',
            ),
          ],
          selectedIndex: _controlAPMP.getPageCount,
          onTabChange: (index) {
            _controlAPMP.setPageCount(index);
          },
        ),
      ),
      floatingActionButton: _controlAPMP.getPageCount == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CreateNotePage(),
                ));
              },
              child: Icon(FontAwesomeIcons.circlePlus),
              backgroundColor: renkler['page3color'],
              foregroundColor: renkler['page4color'],
              splashColor: renkler['page4color'],
            )
          : null,
    );
  }
}
