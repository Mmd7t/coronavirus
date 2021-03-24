import 'package:coronavirus/pages/add_data.dart';
import 'package:coronavirus/pages/settings.dart';
import 'package:coronavirus/pages/show_data/show_data.dart';
import 'package:coronavirus/pages/splash_screen.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:coronavirus/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home/home.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load the shared preferences from disk before the app is started
  final prefs = await SharedPreferences.getInstance();

  // create new theme controller, which will get the currently selected from shared preferences
  final themeController = ThemeController(prefs);

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;

  const MyApp({Key key, this.themeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
        return ThemeControllerProvider(
          controller: themeController,
          child: MaterialApp(
            title: 'Covid 19',
            debugShowCheckedModeBanner: false,
            theme: _buildCurrentTheme(),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              HomePage.routeName: (context) => HomePage(),
              ShowData.routeName: (context) => ShowData(),
              AddDataPage.routeName: (context) => AddDataPage(),
              Settings.routeName: (context) => Settings(),
            },
          ),
        );
      },
    );
  }

  // build the flutter theme from the saved theme string
  ThemeData _buildCurrentTheme() {
    switch (themeController.currentTheme) {
      case "dark":
        return darkTheme;
      case "light":
      default:
        return lightTheme;
    }
  }
}
