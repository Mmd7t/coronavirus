import 'package:coronavirus/pages/settings/settings.dart';
import 'package:coronavirus/providers/accent_color_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class GlobalAppBar extends PreferredSize {
  final bool isHome;
  final bool isSettings;
  final String title;

  const GlobalAppBar(
      {this.isHome = false, this.isSettings = false, this.title = 'Covid 19'});
  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var accentColor = Provider.of<AccentColorProvider>(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
      centerTitle: true,
      leading: (isHome)
          ? const SizedBox()
          : CupertinoNavigationBarBackButton(
              color: colorsMap[accentColor.color]),
      actions: [
        (isSettings)
            ? const SizedBox()
            : IconButton(
                color: colorsMap[accentColor.color],
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed(Settings.routeName);
                },
              ),
      ],
    );
  }
}
