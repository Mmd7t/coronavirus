class DayRead {
  int id;
  String confirmed;
  String dailyCases;
  String recovered;
  String deaths;
  String date;

  DayRead({
    this.id,
    this.dailyCases,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.date,
  });

  DayRead.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    confirmed = map['confirmed'];
    dailyCases = map['dailyCases'];
    recovered = map['recovered'];
    deaths = map['deaths'];
    date = map['date'];
  }

  toMap() {
    return {
      'id': id,
      'confirmed': confirmed,
      'dailyCases': dailyCases,
      'recovered': recovered,
      'deaths': deaths,
      'date': date,
    };
  }
}
