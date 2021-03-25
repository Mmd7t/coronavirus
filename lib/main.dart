import 'package:coronavirus/pages/add_data.dart';
import 'package:coronavirus/pages/settings.dart';
import 'package:coronavirus/pages/show_data/show_data.dart';
import 'package:coronavirus/pages/splash_screen.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home/home.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeController = ThemeController(prefs);
  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;

  MyApp({Key key, this.themeController}) : super(key: key);

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
            theme: _buildTheme(),
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

  final commonTheme = ThemeData(
    primaryColor: Colors.indigo[300],
    dividerColor: Colors.redAccent,
    accentColor: Colors.redAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
    ),
  );

  ThemeData _buildTheme() {
    switch (themeController.currentTheme) {
      case "dark":
        return ThemeData.dark().copyWith(
          primaryColor: commonTheme.primaryColor,
          accentColor: commonTheme.accentColor,
          visualDensity: commonTheme.visualDensity,
          dividerColor: commonTheme.dividerColor,
          scaffoldBackgroundColor: Color(0xFF0E0127),
          inputDecorationTheme: commonTheme.inputDecorationTheme,
        );
      case "light":
      default:
        return ThemeData.light().copyWith(
          primaryColor: commonTheme.primaryColor,
          accentColor: commonTheme.accentColor,
          scaffoldBackgroundColor: Colors.white,
          dividerColor: commonTheme.dividerColor,
          visualDensity: commonTheme.visualDensity,
          inputDecorationTheme: commonTheme.inputDecorationTheme,
        );
    }
  }
}
