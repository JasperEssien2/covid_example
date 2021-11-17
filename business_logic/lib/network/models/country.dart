import 'package:equatable/equatable.dart';

class CountryStats extends Equatable {
  final String? country;
  final String? code;
  final int? active;
  final int? recovered;
  final int? critical;
  final int? deaths;
  final int? totalCases;
  final String? date;

  const CountryStats({
    required this.country,
    required this.code,
    required this.active,
    required this.recovered,
    required this.critical,
    required this.deaths,
    required this.date,
    required this.totalCases,
  });

  CountryStats copyWith({
    String? country,
    String? code,
    int? active,
    int? totalCases,
    int? recovered,
    int? critical,
    int? deaths,
    String? date,
  }) {
    return CountryStats(
      country: country ?? this.country,
      code: code ?? this.code,
      active: active ?? this.active,
      recovered: recovered ?? this.recovered,
      critical: critical ?? this.critical,
      deaths: deaths ?? this.deaths,
      date: date,
      totalCases: totalCases ?? this.totalCases,
    );
  }

  @override
  List<Object?> get props {
    return [
      country,
      code,
      active,
      recovered,
      critical,
      totalCases,
      deaths,
      date,
    ];
  }

  CountryStats.fromJson(Map<String, dynamic> map)
      : country = map['Country'],
        code = map['TwoLetterSymbol'],
        active = map['ActiveCases'] == null ? 0 : int.parse(map['ActiveCases']),
        totalCases = map['TotalCases'] == null ? 0 : int.parse(map['TotalCases'] ?? 0),
        recovered =map['TotalRecovered'] == null ? 0 : int.parse(map['TotalRecovered'] ?? 0),
        critical = map['Serious_Critical'] == null ? 0 :int.parse(map['Serious_Critical'] ?? 0),
        date = map['date'],
        deaths = map['TotalDeaths'] == null ? 0 :int.parse(map['TotalDeaths'] ?? 0);

  CountryStats.fromJsonStats(Map<String, dynamic> map)
      : country = map['Country'],
        code = map['symbol'],
        active = map['ActiveCases'],
        totalCases = map['total_cases'],
        recovered = map['TotalRecovered'],
        critical = map['Serious_Critical'],
        date = map['date'],
        deaths = map['total_deaths'];

  const CountryStats.dummy()
      : country = "Nigeria",
        code = "NG",
        date = null,
        active = 100,
        recovered = 100,
        critical = 300,
        totalCases = 30,
        deaths = 1;
}
