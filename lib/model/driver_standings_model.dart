// MRDataDriverStandings Model
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
      xmlns: json['xmlns'] ?? '',
      series: json['series'],
      url: json['url'],
      limit: json['limit'],
      offset: json['offset'],
      total: json['total'],
      standingsTable: StandingsTable.fromJson(json['StandingsTable']),
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
      season: json['season'],
      round: json['round'],
      standingsLists: (json['StandingsLists'] as List)
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
      season: json['season'],
      round: json['round'],
      driverStandings: (json['DriverStandings'] as List)
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
      position: json['position'],
      positionText: json['positionText'],
      points: json['points'],
      wins: json['wins'],
      driver: Driver.fromJson(json['Driver']),
      constructors: (json['Constructors'] as List)
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
      driverId: json['driverId'],
      permanentNumber: json['permanentNumber'] ?? '',
      code: json['code'] ?? '',
      url: json['url'],
      givenName: json['givenName'],
      familyName: json['familyName'],
      dateOfBirth: json['dateOfBirth'],
      nationality: json['nationality'],
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
      constructorId: json['constructorId'],
      url: json['url'],
      name: json['name'],
      nationality: json['nationality'],
    );
  }
}