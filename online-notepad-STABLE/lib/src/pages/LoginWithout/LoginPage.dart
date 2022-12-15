import 'package:flutter/material.dart';
import 'package:online_notepad/src/settings.dart';
import 'package:provider/provider.dart';
import '../../providers/AppChangeColorsProvider.dart';
import 'login_background_painter.dart';
import '../../providers/AppGoogleLoginProvider.dart';
import '../../providers/AppChangeLanguageProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var renkler = Provider.of<AppChangeColorsProvider>(context).getColorsMap;
    var _controlACLP = Provider.of<AppChangeLanguageProvider>(context);
    Map language = _controlACLP.getLanguageMap; 
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: BackgroundPainter()),
            Column(
              children: [
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Online Notepad V3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(4),
                  child: OutlinedButton.icon(
                    style: ButtonStyle(backgroundColor: renkler['page1ForButton']),
                    label: Text(
                      '| ${language['L_btnStr']}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: renkler['page4color']),
                    ),
                    icon: FaIcon(FontAwesomeIcons.google, color: renkler['page4color']),
                    onPressed: () {
                      var controlALP =
                          Provider.of<AppGoogleLoginProvider>(context, listen: false);
                      controlALP.GoogleLogin();
                    },
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '${language['L_altStr']}',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                  '${language['L_author']}',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ],
            ),
          ],
        ),
      );
}
}