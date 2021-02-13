import 'package:coronavirus/pages/show_data/america_data.dart';
import 'package:coronavirus/pages/show_data/china_data.dart';
import 'package:coronavirus/pages/show_data/egypt_data.dart';
import 'package:coronavirus/pages/show_data/italy_data.dart';
import 'package:flutter/material.dart';

class ShowData extends StatelessWidget {
  static const String routeName = 'showData';

  @override
  Widget build(BuildContext context) {
    var type = ModalRoute.of(context).settings.arguments;

    switch (type) {
      case 0:
        return EgyptData();
        break;
      case 1:
        return AmericaData();
        break;
      case 2:
        return ItalyData();
        break;
      case 3:
        return ChinaData();
        break;
      default:
        return null;
    }
  }
}
