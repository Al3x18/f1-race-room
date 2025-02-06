class MRDataDriverStandings {
  final String xmlns;
  final String series;
  final String url;
  final String limit;
  final String offset;
  final String total;
  final StandingsTable standingsTable;

  MRDataDriverStandings({
    required this.xmlns,
    required this.series,
    required this.url,
    required this.limit,
    required this.offset,
    required this.total,
    required this.standingsTable,
  });

  factory MRDataDriverStandings.fromJson(Map<String, dynamic> json) {
    return MRDataDriverStandings(
      xmlns: json['xmlns'] ?? 'No Data',
      series: json['series'] ?? 'No Data',
      url: json['url'] ?? 'No Data',
      limit: json['limit'] ?? 'No Data',
      offset: json['offset'] ?? 'No Data',
      total: json['total'] ?? 'No Data',
      standingsTable: StandingsTable.fromJson(json['StandingsTable'] ?? {}),
    );
  }
}

// StandingsTable Model
class StandingsTable {
  final String season;
  final String round;
  final List<StandingsList> standingsLists;

  StandingsTable({
    required this.season,
    required this.round,
    required this.standingsLists,
  });

  factory StandingsTable.fromJson(Map<String, dynamic> json) {
    return StandingsTable(
      season: json['season'] ?? 'No Data',
      round: json['round'] ?? 'No Data',
      standingsLists: (json['StandingsLists'] as List? ?? [])
          .map((item) => StandingsList.fromJson(item))
          .toList(),
    );
  }
}

// StandingsList Model
class StandingsList {
  final String season;
  final String round;
  final List<DriverStandings> driverStandings;

  StandingsList({
    required this.season,
    required this.round,
    required this.driverStandings,
  });

  factory StandingsList.fromJson(Map<String, dynamic> json) {
    return StandingsList(
      season: json['season'] ?? 'No Data',
      round: json['round'] ?? 'No Data',
      driverStandings: (json['DriverStandings'] as List? ?? [])
          .map((item) => DriverStandings.fromJson(item))
          .toList(),
    );
  }
}

// DriverStandings Model
class DriverStandings {
  final String position;
  final String positionText;
  final String points;
  final String wins;
  final Driver driver;
  final List<Constructor> constructors;

  DriverStandings({
    required this.position,
    required this.positionText,
    required this.points,
    required this.wins,
    required this.driver,
    required this.constructors,
  });

  factory DriverStandings.fromJson(Map<String, dynamic> json) {
    return DriverStandings(
      position: json['position'] ?? 'ND',
      positionText: json['positionText'] ?? 'No Data',
      points: json['points'] ?? 'No Data',
      wins: json['wins'] ?? 'No Data',
      driver: Driver.fromJson(json['Driver'] ?? {}),
      constructors: (json['Constructors'] as List? ?? [])
          .map((item) => Constructor.fromJson(item))
          .toList(),
    );
  }
}

// Driver Model
class Driver {
  final String driverId;
  final String permanentNumber;
  final String code;
  final String url;
  final String givenName;
  final String familyName;
  final String dateOfBirth;
  final String nationality;

  Driver({
    required this.driverId,
    required this.permanentNumber,
    required this.code,
    required this.url,
    required this.givenName,
    required this.familyName,
    required this.dateOfBirth,
    required this.nationality,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driverId'] ?? 'No Data',
      permanentNumber: json['permanentNumber'] ?? 'No Data',
      code: json['code'] ?? 'No Data',
      url: json['url'] ?? 'No Data',
      givenName: json['givenName'] ?? 'No Data',
      familyName: json['familyName'] ?? 'No Data',
      dateOfBirth: json['dateOfBirth'] ?? 'No Data',
      nationality: json['nationality'] ?? 'No Data',
    );
  }
}

// Constructor Model
class Constructor {
  final String constructorId;
  final String url;
  final String name;
  final String nationality;

  Constructor({
    required this.constructorId,
    required this.url,
    required this.name,
    required this.nationality,
  });

  factory Constructor.fromJson(Map<String, dynamic> json) {
    return Constructor(
      constructorId: json['constructorId'] ?? 'No Data',
      url: json['url'] ?? 'No Data',
      name: json['name'] ?? 'No Data',
      nationality: json['nationality'] ?? 'No Data',
    );
  }
}