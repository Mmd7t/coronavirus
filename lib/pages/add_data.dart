import 'package:coronavirus/constants.dart';
import 'package:coronavirus/db/db.dart';
import 'package:coronavirus/models/day_read.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:coronavirus/widgets/global_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDataPage extends StatefulWidget {
  static const String routeName = 'addDataPage';
  final int dataRelatedTo;

  const AddDataPage({Key key, this.dataRelatedTo}) : super(key: key);
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  TextEditingController confirmed, recovered, dailyCases, deaths;
  var selectedDate = DateTime.now();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    confirmed = TextEditingController();
    recovered = TextEditingController();
    dailyCases = TextEditingController();
    deaths = TextEditingController();
    super.initState();
  }

  var tableName = '';

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    switch (widget.dataRelatedTo) {
      case 0:
        setState(() {
          tableName = egyptDbTable;
        });
        break;
      case 1:
        setState(() {
          tableName = americaDbTable;
        });
        break;
      case 2:
        setState(() {
          tableName = italyDbTable;
        });
        break;
      case 3:
        setState(() {
          tableName = chinaDbTable;
        });
        break;
      default:
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Data",
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            color: Theme.of(context).accentColor,
            icon: const Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            color: Colors.blueAccent,
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await DB.db.insertData(
                    DayRead(
                        date: selectedDate.toString(),
                        confirmed: confirmed.text,
                        dailyCases: dailyCases.text,
                        recovered: recovered.text,
                        deaths: deaths.text),
                    tableName);
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /*---------------------------  Date Input -------------------------------*/
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListTile(
                      title: Text(
                        "Select Date",
                      ),
                      trailing: Text(
                        '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                      ),
                      tileColor: (theme.theme)
                          ? const Color(0xFF131344)
                          : Colors.grey[300],
                      onTap: () async {
                        var picker = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(1),
                          lastDate: DateTime(100000),
                          initialDatePickerMode: DatePickerMode.day,
                        );
                        if (picker != null) {
                          setState(() {
                            selectedDate = picker;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  /*---------------------------  Confirmed Input -------------------------------*/
                  GlobalTextFormField(
                    controller: confirmed,
                    hintText: 'Confirmed',
                  ),
                  const SizedBox(height: 10),
                  /*---------------------------  Daily Cases Input -------------------------------*/
                  GlobalTextFormField(
                    controller: dailyCases,
                    hintText: 'Daily Cases',
                  ),
                  const SizedBox(height: 10),
                  /*---------------------------  Recovered Input -------------------------------*/
                  GlobalTextFormField(
                    controller: recovered,
                    hintText: 'Recovered',
                  ),
                  const SizedBox(height: 10),
                  /*---------------------------  Deaths Input -------------------------------*/
                  GlobalTextFormField(
                    controller: deaths,
                    hintText: 'Deaths',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
