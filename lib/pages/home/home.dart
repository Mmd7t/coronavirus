import 'package:coronavirus/constants.dart';
import 'package:coronavirus/providers/accent_color_provider.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:coronavirus/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contain_box.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imgs = [
    'assets/egypt.png',
    'assets/america.png',
    'assets/italy.png',
    'assets/china.png',
  ];

  final names = ['Egypt', 'America', 'Italy', 'China'];

  final dbTables = [egyptDbTable, americaDbTable, italyDbTable, chinaDbTable];

  @override
  Widget build(BuildContext context) {
    var accentColor = Provider.of<AccentColorProvider>(context);
    return Scaffold(
      appBar: const GlobalAppBar(isHome: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 11 / 16,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) => ContainBox(
                  countryName: names[index],
                  imgPath: imgs[index],
                  dbTableName: dbTables[index],
                  index: index,
                ),
              ),
            ),
            MaterialButton(
              child: const Text('Update Data'),
              color: colorsMap[accentColor.color],
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: const StadiumBorder(),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
