String BASE_URL = "https://covid-19-data.p.rapidapi.com/";

class _Covid{
  String get latestAllCountries => "${BASE_URL}country/all";

  String get dailyReportAllCountries => "${BASE_URL}report/country/all";

  String get dailyReportByCountryName => "${BASE_URL}report/country/name";
}

final covidEndpoints = _Covid();