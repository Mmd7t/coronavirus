import 'package:coronavirus/constants.dart';
import 'package:coronavirus/db/db.dart';
import 'package:coronavirus/models/day_read.dart';
import 'package:coronavirus/providers/accent_color_provider.dart';
import 'package:coronavirus/providers/theme_provider.dart';
import 'package:coronavirus/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../add_data.dart';
import '../edit_data.dart';

class ChinaData extends StatefulWidget {
  @override
  _ChinaDataState createState() => _ChinaDataState();
}

class _ChinaDataState extends State<ChinaData> {
  DB database = DB.db;
  int count = 0;
  List<DayRead> notesList;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var accentColor = Provider.of<AccentColorProvider>(context);

    if (notesList == null) {
      notesList = List<DayRead>();
      updateListView();
    }
    return Scaffold(
      appBar: const GlobalAppBar(title: 'China'),
      body: FutureBuilder(
          future: database.getAllData(chinaDbTable),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var note = snapshot.data[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 13),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: (theme.theme)
                          ? Border.fromBorderSide(BorderSide.none)
                          : Border.all(color: colorsMap[accentColor.color]),
                      color: (theme.theme)
                          ? const Color(0xFF131344)
                          : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${note.date}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: colorsMap[accentColor.color],
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text('confirmed : ${note.confirmed}'),
                              const SizedBox(height: 3),
                              Text('daily cases : ${note.dailyCases}'),
                              const SizedBox(height: 3),
                              Text('deaths : ${note.deaths}'),
                              const SizedBox(height: 3),
                              Text('recovered : ${note.recovered}'),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                bool result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => EditDataPage(
                                              id: this.notesList[index].id,
                                              dataRelatedTo: 3,
                                              data: this.notesList[index].date,
                                              confirmed: this
                                                  .notesList[index]
                                                  .confirmed,
                                              dailyCases: this
                                                  .notesList[index]
                                                  .dailyCases,
                                              recovered: this
                                                  .notesList[index]
                                                  .recovered,
                                              deaths:
                                                  this.notesList[index].deaths,
                                            )));
                                if (result == true) {
                                  updateListView();
                                }
                              },
                              color: Colors.blueAccent,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                database.deleteData(
                                    this.notesList[index].id, chinaDbTable);
                                updateListView();
                              },
                              color: Theme.of(context).accentColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorsMap[accentColor.color],
        child: const Icon(Icons.add),
        onPressed: () async {
          bool result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddDataPage(dataRelatedTo: 3)));
          if (result == true) {
            updateListView();
            // await notelist();
          }
        },
      ),
    );
  }

  updateListView() {
    final Future<Database> futureDb = database.initDB();
    futureDb.then((value) {
      Future<List<DayRead>> noteListFuture = database.getAllData(chinaDbTable);
      noteListFuture.then((value) {
        setState(() {
          this.notesList = value;
          this.count = value.length;
        });
      });
    });
  }
}
