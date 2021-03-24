import 'package:coronavirus/providers/theme_provider.dart';
import 'package:coronavirus/widgets/global_appbar.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  static const String routeName = 'settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController.of(context);
    return Scaffold(
      appBar: const GlobalAppBar(isSettings: true, title: 'Settings'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: (themeController.currentTheme == 'dark')
                  ? Border.fromBorderSide(BorderSide.none)
                  : Border.all(color: Theme.of(context).accentColor),
              color: (themeController.currentTheme == 'dark')
                  ? const Color(0xFF131344)
                  : Colors.white,
            ),
            child: SwitchListTile(
              title: Text('Dark Theme'),
              inactiveTrackColor:
                  Theme.of(context).accentColor.withOpacity(0.3),
              activeColor: Theme.of(context).accentColor,
              value: (themeController.currentTheme == 'dark'),
              onChanged: (value) {
                setState(() {
                  themeController.setTheme((value) ? "dark" : "light");
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
