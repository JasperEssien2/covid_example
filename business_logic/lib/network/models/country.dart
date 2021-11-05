import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String country;
  final String code;
  final int confirmed;
  final int recovered;
  final int critical;
  final int deaths;
  final double latitude;
  final double longitude;
  final double lastChange;
  final double lastUpdate;

  const Country({
    required this.country,
    required this.code,
    required this.confirmed,
    required this.recovered,
    required this.critical,
    required this.deaths,
    required this.latitude,
    required this.longitude,
    required this.lastChange,
    required this.lastUpdate,
  });

  Country copyWith({
    String? country,
    String? code,
    int? confirmed,
    int? recovered,
    int? critical,
    int? deaths,
    double? latitude,
    double? longitude,
    double? lastChange,
    double? lastUpdate,
  }) {
    return Country(
      country: country ?? this.country,
      code: code ?? this.code,
      confirmed: confirmed ?? this.confirmed,
      recovered: recovered ?? this.recovered,
      critical: critical ?? this.critical,
      deaths: deaths ?? this.deaths,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      lastChange: lastChange ?? this.lastChange,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  @override
  List<Object> get props {
    return [
      country,
      code,
      confirmed,
      recovered,
      critical,
      deaths,
      latitude,
      longitude,
      lastChange,
      lastUpdate,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'code': code,
      'confirmed': confirmed,
      'recovered': recovered,
      'critical': critical,
      'deaths': deaths,
      'latitude': latitude,
      'longitude': longitude,
      'lastChange': lastChange,
      'lastUpdate': lastUpdate,
    };
  }

  Country.fromMap(Map<String, dynamic> map)
      : country = map['country'],
        code = map['code'],
        confirmed = map['confirmed'],
        recovered = map['recovered'],
        critical = map['critical'],
        deaths = map['deaths'],
        latitude = map['latitude'],
        longitude = map['longitude'],
        lastChange = map['lastChange'],
        lastUpdate = map['lastUpdate'];
}
