import 'package:coronavirus/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      leading: (isHome == true)
          ? const SizedBox()
          : CupertinoNavigationBarBackButton(
              color: Theme.of(context).accentColor),
      actions: [
        (isSettings)
            ? const SizedBox()
            : IconButton(
                color: Theme.of(context).accentColor,
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed(Settings.routeName);
                },
              ),
      ],
    );
  }
}
