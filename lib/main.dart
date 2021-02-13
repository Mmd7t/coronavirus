import 'package:coronavirus/pages/add_data.dart';
import 'package:coronavirus/pages/settings/settings.dart';
import 'package:coronavirus/pages/show_data/show_data.dart';
import 'package:coronavirus/pages/splash_screen.dart';
import 'package:coronavirus/providers/accent_color_provider.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:coronavirus/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<AccentColorProvider>(
            create: (context) => AccentColorProvider()),
      ],
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'Covid 19',
              debugShowCheckedModeBanner: false,
              theme: value.theme ? darkTheme : lightTheme,
              initialRoute: SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (context) => SplashScreen(),
                HomePage.routeName: (context) => HomePage(),
                ShowData.routeName: (context) => ShowData(),
                AddDataPage.routeName: (context) => AddDataPage(),
                Settings.routeName: (context) => Settings(),
              },
            );
          },
        );
      },
    );
  }
}
