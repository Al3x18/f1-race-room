class MRDataRaceSchedule {
  final String xmlns;
  final String series;
  final String url;
  final String limit;
  final String offset;
  final String total;
  final RaceTable raceTable;

  MRDataRaceSchedule({
    required this.xmlns,
    required this.series,
    required this.url,
    required this.limit,
    required this.offset,
    required this.total,
    required this.raceTable,
  });

  factory MRDataRaceSchedule.fromJson(Map<String, dynamic> json) {
    return MRDataRaceSchedule(
      xmlns: json['xmlns'] ?? 'No Data',
      series: json['series'] ?? 'No Data',
      url: json['url'] ?? 'No Data',
      limit: json['limit']?.toString() ?? 'No Data',
      offset: json['offset']?.toString() ?? 'No Data',
      total: json['total']?.toString() ?? 'No Data',
      raceTable: RaceTable.fromJson(json['RaceTable']),
    );
  }
}

class RaceTable {
  final String season;
  final List<Race> races;

  RaceTable({
    required this.season,
    required this.races,
  });

  factory RaceTable.fromJson(Map<String, dynamic> json) {
    return RaceTable(
      season: json['season'] ?? 'No Data',
      races: List<Race>.from(json['Races']?.map((x) => Race.fromJson(x)) ?? []),
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
  final String? time;
  final FirstPractice? firstPractice;
  final SecondPractice? secondPractice;
  final ThirdPractice? thirdPractice;
  final Qualifying? qualifying;
  final Sprint? sprint;
  final SprintQualifying? sprintQualifying;

  Race({
    required this.season,
    required this.round,
    required this.url,
    required this.raceName,
    required this.circuit,
    required this.date,
    this.time,
    this.firstPractice,
    this.secondPractice,
    this.thirdPractice,
    this.qualifying,
    this.sprint,
    this.sprintQualifying,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
      season: json['season'] ?? 'No Data',
      round: json['round']?.toString() ?? 'No Data',
      url: json['url'] ?? 'No Data',
      raceName: json['raceName'] ?? 'No Data',
      circuit: Circuit.fromJson(json['Circuit']),
      date: json['date'] ?? 'No Data',
      time: json['time'] ?? 'No Data',
      firstPractice: json['FirstPractice'] != null ? FirstPractice.fromJson(json['FirstPractice']) : null,
      secondPractice: json['SecondPractice'] != null ? SecondPractice.fromJson(json['SecondPractice']) : null,
      thirdPractice: json['ThirdPractice'] != null ? ThirdPractice.fromJson(json['ThirdPractice']) : null,
      qualifying: json['Qualifying'] != null ? Qualifying.fromJson(json['Qualifying']) : null,
      sprint: json['Sprint'] != null ? Sprint.fromJson(json['Sprint']) : null,
      sprintQualifying: json['SprintQualifying'] != null ? SprintQualifying.fromJson(json['SprintQualifying']) : null,
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
      circuitId: json['circuitId'] ?? 'No Data',
      url: json['url'] ?? 'No Data',
      circuitName: json['circuitName'] ?? 'No Data',
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
      lat: json['lat'] ?? 'No Data',
      long: json['long'] ?? 'No Data',
      locality: json['locality'] ?? 'No Data',
      country: json['country'] ?? 'No Data',
    );
  }
}

class FirstPractice {
  final String date;
  final String time;

  FirstPractice({
    required this.date,
    required this.time,
  });

  factory FirstPractice.fromJson(Map<String, dynamic> json) {
    return FirstPractice(
      date: json['date'] ?? 'No Data',
      time: json['time'] ?? 'No Data',
    );
  }
}

class SecondPractice {
  final String date;
  final String time;

  SecondPractice({
    required this.date,
    required this.time,
  });

  factory SecondPractice.fromJson(Map<String, dynamic> json) {
    return SecondPractice(
      date: json['date'] ?? 'No Data',
      time: json['time'] ?? 'No Data',
    );
  }
}

class ThirdPractice {
  final String date;
  final String time;

  ThirdPractice({
    required this.date,
    required this.time,
  });

  factory ThirdPractice.fromJson(Map<String, dynamic> json) {
    return ThirdPractice(
      date: json['date'] ?? 'No Data',
      time: json['time'] ?? 'No Data',
    );
  }
}

class Qualifying {
  final String date;
  final String time;

  Qualifying({
    required this.date,
    required this.time,
  });

  factory Qualifying.fromJson(Map<String, dynamic> json) {
    return Qualifying(
      date: json['date'] ?? 'No Data',
      time: json['time'] ?? 'No Data',
    );
  }
}

class Sprint {
  final String date;
  final String time;

  Sprint({
    required this.date,
    required this.time,
  });

  factory Sprint.fromJson(Map<String, dynamic> json) {
    return Sprint(
      date: json['date'] ?? 'No Data',
      time: json['time'] ?? 'No Data',
    );
  }
}

class SprintQualifying {
  final String date;
  final String time;

  SprintQualifying({
    required this.date,
    required this.time,
  });

  factory SprintQualifying.fromJson(Map<String, dynamic> json) {
    return SprintQualifying(
      date: json['date'] ?? 'No Data',
      time: json['time'] ?? 'No Data',
    );
  }
}
