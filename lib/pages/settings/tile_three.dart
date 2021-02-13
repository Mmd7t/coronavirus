import 'package:coronavirus/providers/accent_color_provider.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SettingsTileThree extends StatefulWidget {
  @override
  _SettingsTileThreeState createState() => _SettingsTileThreeState();
}

class _SettingsTileThreeState extends State<SettingsTileThree> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var accentColor = Provider.of<AccentColorProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: (theme.theme)
            ? Border.fromBorderSide(BorderSide.none)
            : Border.all(color: colorsMap[accentColor.color]),
        color: (theme.theme) ? const Color(0xFF131344) : Colors.white,
      ),
      child: SwitchListTile(
        title: Text('Dark Theme'),
        inactiveTrackColor: colorsMap[accentColor.color].withOpacity(0.3),
        activeColor: colorsMap[accentColor.color],
        value: theme.theme,
        onChanged: (value) {
          setState(() {
            theme.setDarkTheme(value);
          });
        },
      ),
    );
  }
}
