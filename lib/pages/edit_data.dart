import 'package:coronavirus/db/db.dart';
import 'package:coronavirus/models/day_read.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:coronavirus/widgets/global_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class EditDataPage extends StatefulWidget {
  final int id;
  final int dataRelatedTo;
  final String data;
  final String confirmed;
  final String recovered;
  final String dailyCases;
  final String deaths;

  const EditDataPage({
    Key key,
    this.id,
    this.dataRelatedTo,
    this.data,
    this.confirmed,
    this.recovered,
    this.dailyCases,
    this.deaths,
  }) : super(key: key);
  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  TextEditingController confirmedController = TextEditingController();
  TextEditingController recoveredController = TextEditingController();
  TextEditingController dailyCasesController = TextEditingController();
  TextEditingController deathsController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.parse(widget.data);
    confirmedController.text = widget.confirmed;
    recoveredController.text = widget.recovered;
    dailyCasesController.text = widget.dailyCases;
    deathsController.text = widget.deaths;
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
          "Edit Data",
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
                await DB.db.updateData(
                    DayRead(
                        id: widget.id,
                        date: selectedDate.toString(),
                        confirmed: confirmedController.text,
                        dailyCases: dailyCasesController.text,
                        recovered: recoveredController.text,
                        deaths: deathsController.text),
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
                    controller: confirmedController,
                    hintText: 'Confirmed',
                  ),
                  const SizedBox(height: 10),
                  /*---------------------------  Daily Cases Input -------------------------------*/
                  GlobalTextFormField(
                    controller: dailyCasesController,
                    hintText: 'Daily Cases',
                  ),
                  const SizedBox(height: 10),
                  /*---------------------------  Recovered Input -------------------------------*/
                  GlobalTextFormField(
                    controller: recoveredController,
                    hintText: 'Recovered',
                  ),
                  const SizedBox(height: 10),
                  /*---------------------------  Deaths Input -------------------------------*/
                  GlobalTextFormField(
                    controller: deathsController,
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
