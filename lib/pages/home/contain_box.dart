import 'package:coronavirus/constants.dart';
import 'package:coronavirus/db/db.dart';
import 'package:coronavirus/models/day_read.dart';
import 'package:coronavirus/providers/accent_color_provider.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../show_data/show_data.dart';

class ContainBox extends StatefulWidget {
  const ContainBox({
    Key key,
    this.countryName,
    this.imgPath,
    this.index,
    this.dbTableName,
  }) : super(key: key);

  final String countryName;
  final String imgPath;
  final int index;
  final String dbTableName;

  @override
  _ContainBoxState createState() => _ContainBoxState();
}

class _ContainBoxState extends State<ContainBox> {
  DB database = DB.db;
  var res;
  var row;
  var timeNow = DateTime.now();
  DayRead dd = DayRead();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var accentColor = Provider.of<AccentColorProvider>(context);
    final radius = BorderRadius.circular(20);

    return InkWell(
      borderRadius: radius,
      splashColor: colorsMap[accentColor.color],
      enableFeedback: true,
      onTap: () {
        Navigator.of(context)
            .pushNamed(ShowData.routeName, arguments: widget.index);
      },
      child: Card(
        margin: const EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: (theme.theme)
                ? Border.fromBorderSide(BorderSide.none)
                : Border.all(color: colorsMap[accentColor.color]),
            color: (theme.theme) ? const Color(0xFF131344) : Colors.white,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    widget.imgPath,
                    width: constraints.maxWidth - 30,
                  ),
                ),
                Text(
                  widget.countryName,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: colorsMap[accentColor.color],
                      ),
                ),
                FutureBuilder(
                  future: database.getSingleData(widget.dbTableName),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data[0];
                      return Text(data['confirmed']);
                    } else {
                      return Text('No Data defined');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
