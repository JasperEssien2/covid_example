import 'package:business_logic/business_logic_export.dart';

class CountryStatsViewModel extends ListBaseViewModel<CountryStats> {
  @override
  void addToList(List<CountryStats> items, {bool clear = true}) {
    if (items.isNotEmpty) {
      currentlySelected = items.first;
    }
    super.addToList(items, clear: clear);
  }
}
