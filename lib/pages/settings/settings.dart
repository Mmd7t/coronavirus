import 'package:coronavirus/pages/settings/tile_three.dart';
import 'package:coronavirus/widgets/global_appbar.dart';
import 'package:flutter/material.dart';

import 'tile_one.dart';
import 'tile_two.dart';

class Settings extends StatelessWidget {
  static const String routeName = 'settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(isSettings: true, title: 'Settings'),
      body: Column(
        children: [
          SettingsTileOne(),
          SettingsTileTwo(),
          SettingsTileThree(),
        ],
      ),
    );
  }
}
