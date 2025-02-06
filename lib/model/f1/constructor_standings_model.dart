class MRDataConstructorStandings {
 final String xmlns;
  final String series;
  final String url;
  final String limit;
  final String offset;
  final String total;
  final StandingsTable standingsTable;

  MRDataConstructorStandings({
    required this.xmlns,
    required this.series,
    required this.url,
    required this.limit,
    required this.offset,
    required this.total,
    required this.standingsTable,
  });

  factory MRDataConstructorStandings.fromJson(Map<String, dynamic> json) {
    return MRDataConstructorStandings(
      xmlns: json['xmlns'] ?? 'No Data',
      series: json['series'] ?? 'No Data',
      url: json['url'] ?? 'No Data',
      limit: json['limit'] ?? 'No Data',
      offset: json['offset'] ?? 'No Data',
      total: json['total'] ?? 'No Data',
      standingsTable: StandingsTable.fromJson(json['StandingsTable']),
    );
  }
}

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

class StandingsList {
  final String season;
  final String round;
  final List<ConstructorStandings> constructorStandings;

  StandingsList({
    required this.season,
    required this.round,
    required this.constructorStandings,
  });

  factory StandingsList.fromJson(Map<String, dynamic> json) {
    return StandingsList(
      season: json['season'] ?? 'No Data',
      round: json['round'] ?? 'No Data',
      constructorStandings: (json['ConstructorStandings'] as List? ?? [])
          .map((item) => ConstructorStandings.fromJson(item))
          .toList(),
    );
  }
}

class ConstructorStandings {
  final String position;
  final String positionText;
  final String points;
  final String wins;
  final Constructor constructor;

  ConstructorStandings({
    required this.position,
    required this.positionText,
    required this.points,
    required this.wins,
    required this.constructor,
  });

  factory ConstructorStandings.fromJson(Map<String, dynamic> json) {
    return ConstructorStandings(
      position: json['position'] ?? 'No Data',
      positionText: json['positionText'] ?? 'No Data',
      points: json['points'] ?? 'No Data',
      wins: json['wins'] ?? 'No Data',
      constructor: Constructor.fromJson(json['Constructor']),
    );
  }
}

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