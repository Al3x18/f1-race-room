class MRDataRaceResults {
  final String xmlns;
  final String series;
  final String url;
  final int limit;
  final int offset;
  final int total;
  final RaceTable raceTable;

  MRDataRaceResults({
    required this.xmlns,
    required this.series,
    required this.url,
    required this.limit,
    required this.offset,
    required this.total,
    required this.raceTable,
  });

  factory MRDataRaceResults.fromJson(Map<String, dynamic> json) {
    return MRDataRaceResults(
      xmlns: json['xmlns'] ?? "Data not available",
      series: json['series'] ?? "Data not available",
      url: json['url'] ?? "Data not available",
      limit: int.tryParse(json['limit'].toString()) ?? 0,
      offset: int.tryParse(json['offset'].toString()) ?? 0,
      total: int.tryParse(json['total'].toString()) ?? 0,
      raceTable: RaceTable.fromJson(json['RaceTable']),
    );
  }
}

class RaceTable {
  final String season;
  final String round;
  final List<Race> races;

  RaceTable({
    required this.season,
    required this.round,
    required this.races,
  });

  factory RaceTable.fromJson(Map<String, dynamic> json) {
    var racesList = json['Races'] as List? ?? [];
    List<Race> races = racesList.map((race) => Race.fromJson(race)).toList();

    return RaceTable(
      season: json['season'] ?? "Data not available",
      round: json['round'] ?? "Data not available",
      races: races,
    );
  }
}

class Race {
  final String season;
  final String round;
  final String url;
  final String raceName;
  final Circuit circuit;
  final String date;
  final String time;
  final List<Result> results;

  Race({
    required this.season,
    required this.round,
    required this.url,
    required this.raceName,
    required this.circuit,
    required this.date,
    required this.time,
    required this.results,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    var resultsList = json['Results'] as List? ?? [];
    List<Result> results = resultsList.map((result) => Result.fromJson(result)).toList();

    return Race(
      season: json['season'] ?? "Data not available",
      round: json['round'] ?? "Data not available",
      url: json['url'] ?? "Data not available",
      raceName: json['raceName'] ?? "Data not available",
      circuit: Circuit.fromJson(json['Circuit']),
      date: json['date'] ?? "Data not available",
      time: json['time'] ?? "Data not available",
      results: results,
    );
  }
}

class Circuit {
  final String circuitId;
  final String url;
  final String circuitName;
  final Location location;

  Circuit({
    required this.circuitId,
    required this.url,
    required this.circuitName,
    required this.location,
  });

  factory Circuit.fromJson(Map<String, dynamic> json) {
    return Circuit(
      circuitId: json['circuitId'] ?? "Data not available",
      url: json['url'] ?? "Data not available",
      circuitName: json['circuitName'] ?? "Data not available",
      location: Location.fromJson(json['Location']),
    );
  }
}

class Location {
  final String lat;
  final String long;
  final String locality;
  final String country;

  Location({
    required this.lat,
    required this.long,
    required this.locality,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'] ?? "Data not available",
      long: json['long'] ?? "Data not available",
      locality: json['locality'] ?? "Data not available",
      country: json['country'] ?? "Data not available",
    );
  }
}

class Result {
  final String number;
  final String position;
  final String positionText;
  final String points;
  final Driver driver;
  final Constructor constructor;
  final String grid;
  final String laps;
  final String status;
  final Time? time;
  final FastestLap? fastestLap;

  Result({
    required this.number,
    required this.position,
    required this.positionText,
    required this.points,
    required this.driver,
    required this.constructor,
    required this.grid,
    required this.laps,
    required this.status,
    this.time,
    this.fastestLap,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      number: json['number'] ?? "Data not available",
      position: json['position'] ?? "Data not available",
      positionText: json['positionText'] ?? "Data not available",
      points: json['points'] ?? "Data not available",
      driver: Driver.fromJson(json['Driver']),
      constructor: Constructor.fromJson(json['Constructor']),
      grid: json['grid'] ?? "Data not available",
      laps: json['laps'] ?? "Data not available",
      status: json['status'] ?? "Data not available",
      time: json['Time'] != null ? Time.fromJson(json['Time']) : null,
      fastestLap: json['FastestLap'] != null ? FastestLap.fromJson(json['FastestLap']) : null,
    );
  }
}

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
      driverId: json['driverId'] ?? "Data not available",
      permanentNumber: json['permanentNumber'] ?? "",
      code: json['code'] ?? "Data not available",
      url: json['url'] ?? "Data not available",
      givenName: json['givenName'] ?? "Data not available",
      familyName: json['familyName'] ?? "Data not available",
      dateOfBirth: json['dateOfBirth'] ?? "Data not available",
      nationality: json['nationality'] ?? "Data not available",
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
      constructorId: json['constructorId'] ?? "Data not available",
      url: json['url'] ?? "Data not available",
      name: json['name'] ?? "Data not available",
      nationality: json['nationality'] ?? "Data not available",
    );
  }
}

class Time {
  final String millis;
  final String time;

  Time({
    required this.millis,
    required this.time,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      millis: json['millis'] ?? "Data not available",
      time: json['time'] ?? "Data not available",
    );
  }
}

class FastestLap {
  final String rank;
  final String lap;
  final Time time;
  final AverageSpeed averageSpeed;

  FastestLap({
    required this.rank,
    required this.lap,
    required this.time,
    required this.averageSpeed,
  });

  factory FastestLap.fromJson(Map<String, dynamic> json) {
    return FastestLap(
      rank: json['rank'] ?? "Data not available",
      lap: json['lap'] ?? "Data not available",
      time: Time.fromJson(json['Time']),
      averageSpeed: AverageSpeed.fromJson(json['AverageSpeed']),
    );
  }
}

class AverageSpeed {
  final String units;
  final String speed;

  AverageSpeed({
    required this.units,
    required this.speed,
  });

  factory AverageSpeed.fromJson(Map<String, dynamic> json) {
    return AverageSpeed(
      units: json['units'] ?? "Data not available",
      speed: json['speed'] ?? "Data not available",
    );
  }
}