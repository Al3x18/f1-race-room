class MRDataDriverLaps {
  final String xmlns;
  final String series;
  final String url;
  final String limit;
  final String offset;
  final String total;
  final RaceTable raceTable;

  MRDataDriverLaps({
    this.xmlns = "No Data",
    this.series = "No Data",
    this.url = "No Data",
    this.limit = "No Data",
    this.offset = "No Data",
    this.total = "No Data",
    required this.raceTable,
  });

  factory MRDataDriverLaps.fromJson(Map<String, dynamic> json) {
    return MRDataDriverLaps(
      xmlns: json['xmlns'] ?? "No Data",
      series: json['series'] ?? "No Data",
      url: json['url'] ?? "No Data",
      limit: json['limit'] ?? "No Data",
      offset: json['offset'] ?? "No Data",
      total: json['total'] ?? "No Data",
      raceTable: RaceTable.fromJson(json['RaceTable'] ?? {}),
    );
  }
}

class RaceTable {
  final String season;
  final String round;
  final String driverId;
  final List<Race> races;

  RaceTable({
    this.season = "No Data",
    this.round = "No Data",
    this.driverId = "No Data",
    this.races = const [],
  });

  factory RaceTable.fromJson(Map<String, dynamic> json) {
    return RaceTable(
      season: json['season'] ?? "No Data",
      round: json['round'] ?? "No Data",
      driverId: json['driverId'] ?? "No Data",
      races: (json['Races'] as List<dynamic>?)
              ?.map((raceJson) => Race.fromJson(raceJson))
              .toList() ?? [],
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
  final List<Lap> laps;

  Race({
    this.season = "No Data",
    this.round = "No Data",
    this.url = "No Data",
    this.raceName = "No Data",
    required this.circuit,
    this.date = "No Data",
    this.time = "No Data",
    this.laps = const [],
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
      season: json['season'] ?? "No Data",
      round: json['round'] ?? "No Data",
      url: json['url'] ?? "No Data",
      raceName: json['raceName'] ?? "No Data",
      circuit: Circuit.fromJson(json['Circuit'] ?? {}),
      date: json['date'] ?? "No Data",
      time: json['time'] ?? "No Data",
      laps: (json['Laps'] as List<dynamic>?)
              ?.map((lapJson) => Lap.fromJson(lapJson))
              .toList() ?? [],
    );
  }
}

class Circuit {
  final String circuitId;
  final String url;
  final String circuitName;
  final Location location;

  Circuit({
    this.circuitId = "No Data",
    this.url = "No Data",
    this.circuitName = "No Data",
    required this.location,
  });

  factory Circuit.fromJson(Map<String, dynamic> json) {
    return Circuit(
      circuitId: json['circuitId'] ?? "No Data",
      url: json['url'] ?? "No Data",
      circuitName: json['circuitName'] ?? "No Data",
      location: Location.fromJson(json['Location'] ?? {}),
    );
  }
}

class Location {
  final String lat;
  final String long;
  final String locality;
  final String country;

  Location({
    this.lat = "No Data",
    this.long = "No Data",
    this.locality = "No Data",
    this.country = "No Data",
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'] ?? "No Data",
      long: json['long'] ?? "No Data",
      locality: json['locality'] ?? "No Data",
      country: json['country'] ?? "No Data",
    );
  }
}

class Lap {
  final String number;
  final List<Timing> timings;

  Lap({
    this.number = "No Data",
    this.timings = const [],
  });

  factory Lap.fromJson(Map<String, dynamic> json) {
    return Lap(
      number: json['number'] ?? "No Data",
      timings: (json['Timings'] as List<dynamic>?)
                ?.map((timingJson) => Timing.fromJson(timingJson))
                .toList() ?? [],
    );
  }
}

class Timing {
  final String driverId;
  final String position;
  final String time;

  Timing({
    this.driverId = "No Data",
    this.position = "No Data",
    this.time = "No Data",
  });

  factory Timing.fromJson(Map<String, dynamic> json) {
    return Timing(
      driverId: json['driverId'] ?? "No Data",
      position: json['position'] ?? "No Data",
      time: json['time'] ?? "No Data",
    );
  }
}