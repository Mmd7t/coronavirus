import 'package:coronavirus/constants.dart';
import 'package:coronavirus/providers/accent_color_provider.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTileOne extends StatelessWidget {
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
      child: ListTile(
        title: Text('Change Accent Color'),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: colorsMap[accentColor.color],
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Accent Color',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      itemBuilder: (context, index) => MaterialButton(
                        color: colorsMap[index],
                        onPressed: () {
                          accentColor.setColor(colorsMap.keys.elementAt(index));
                          Navigator.of(context).pop();
                        },
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
