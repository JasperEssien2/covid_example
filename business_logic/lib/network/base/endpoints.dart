// ignore: non_constant_identifier_names
String BASE_URL =
    "https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/";

class _Covid {
  String reportByCountry(String name, String iso) =>
      "${BASE_URL}npm-covid-data/country-report-iso-based/$name/$iso";

  String sixMonthStatsForCountry(String iso) => "${BASE_URL}covid-ovid-data/sixmonth/$iso";
}

final covidEndpoints = _Covid();
