class WeatherData {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  WeatherData({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      coord: Coord.fromJson(json['coord'] ?? {}),
      weather: json['weather'] != null
          ? List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x)))
          : [Weather.defaultWeather()],
      base: json['base'] ?? "No Data",
      main: Main.fromJson(json['main'] ?? {}),
      visibility: json['visibility'] ?? 0,
      wind: Wind.fromJson(json['wind'] ?? {}),
      clouds: Clouds.fromJson(json['clouds'] ?? {}),
      dt: json['dt'] ?? 0,
      sys: Sys.fromJson(json['sys'] ?? {}),
      timezone: json['timezone'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? "No Data",
      cod: json['cod'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': coord.toJson(),
      'weather': weather.map((x) => x.toJson()).toList(),
      'base': base,
      'main': main.toJson(),
      'visibility': visibility,
      'wind': wind.toJson(),
      'clouds': clouds.toJson(),
      'dt': dt,
      'sys': sys.toJson(),
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }
}

class Coord {
  double lon;
  double lat;

  Coord({this.lon = 0.0, this.lat = 0.0});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon']?.toDouble() ?? 0.0,
      lat: json['lat']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    this.id = 0,
    this.main = "No Data",
    this.description = "No Data",
    this.icon = "No Data",
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'] ?? 0,
      main: json['main'] ?? "No Data",
      description: json['description'] ?? "No Data",
      icon: json['icon'] ?? "No Data",
    );
  }

  static Weather defaultWeather() {
    return Weather();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  Main({
    this.temp = 0.0,
    this.feelsLike = 0.0,
    this.tempMin = 0.0,
    this.tempMax = 0.0,
    this.pressure = 0,
    this.humidity = 0,
    this.seaLevel = 0,
    this.grndLevel = 0,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp']?.toDouble() ?? 0.0,
      feelsLike: json['feels_like']?.toDouble() ?? 0.0,
      tempMin: json['temp_min']?.toDouble() ?? 0.0,
      tempMax: json['temp_max']?.toDouble() ?? 0.0,
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
      seaLevel: json['sea_level'] ?? 0,
      grndLevel: json['grnd_level'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
    };
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({this.speed = 0.0, this.deg = 0, this.gust = 0.0});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed']?.toDouble() ?? 0.0,
      deg: json['deg'] ?? 0,
      gust: json['gust']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}

class Clouds {
  int all;

  Clouds({this.all = 0});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys({
    this.type = 0,
    this.id = 0,
    this.country = "No Data",
    this.sunrise = 0,
    this.sunset = 0,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'] ?? 0,
      id: json['id'] ?? 0,
      country: json['country'] ?? "No Data",
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}