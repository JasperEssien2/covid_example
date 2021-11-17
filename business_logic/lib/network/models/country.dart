import 'package:equatable/equatable.dart';

class CountryStats extends Equatable {
  final String? country;
  final String? code;
  final int? active;
  final int? recovered;
  final int? critical;
  final int? deaths;
  final int? newDeaths;
  final int? totalCases;
  final int? newCases;
  final String? date;

  const CountryStats({
    required this.country,
    required this.code,
    required this.active,
    required this.recovered,
    required this.critical,
    required this.deaths,
    required this.newDeaths,
    required this.newCases,
    required this.date,
    required this.totalCases,
  });

  CountryStats copyWith({
    String? country,
    String? code,
    int? active,
    int? totalCases,
    int? newCases,
    int? recovered,
    int? critical,
    int? deaths,
    int? newDeaths,
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
      newCases: newCases ?? this.newCases,
      newDeaths: newDeaths ?? this.newDeaths,
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
      newCases,
      newDeaths
    ];
  }

  CountryStats.fromJson(Map<String, dynamic> map)
      : country = map['Country'],
        code = map['TwoLetterSymbol'],
        active = map['ActiveCases'] ?? 0,
        newDeaths = null,
        newCases = null,
        totalCases = map['TotalCases'] ?? 0,
        recovered = map['TotalRecovered'] == null
            ? 0
            : int.parse(map['TotalRecovered']),
        critical = map['Serious_Critical'] ?? 0,
        date = map['date'],
        deaths = map['TotalDeaths'] ?? 0;

  CountryStats.fromJsonStats(Map<String, dynamic> map)
      : country = map['Country'],
        code = map['symbol'],
        active = map['ActiveCases'],
        totalCases = map['total_cases'],
        recovered = map['TotalRecovered'],
        critical = map['Serious_Critical'],
        date = map['date'],
        newCases = map['new_cases'],
        newDeaths = map['new_deaths'],
        deaths = map['total_deaths'];

  const CountryStats.dummy()
      : country = "Nigeria",
        code = "NG",
        date = null,
        active = 100,
        recovered = 100,
        newDeaths = null,
        newCases = null,
        critical = 300,
        totalCases = 30,
        deaths = 1;
}
