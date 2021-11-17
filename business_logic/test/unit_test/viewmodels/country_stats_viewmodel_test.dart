import 'package:business_logic/network/network_export.dart';
import 'package:business_logic/view_model/country_stats_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late CountryStatsViewModel viewModel;

  setUp(
    () {
      viewModel = CountryStatsViewModel();
    },
  );

  group(
    "Test addToList()",
    () {
      test(
        "Ensure that items are cleared before insertion of new items "
        "when addList(items, clear = true)",
        () {
          viewModel.itemList = [
            const CountryStats.dummy().copyWith(totalCases: 40),
          ];

          viewModel.addToList(
            [
              const CountryStats.dummy().copyWith(totalCases: 400),
              const CountryStats.dummy().copyWith(totalCases: 3, recovered: 45),
            ],
          );
          expect(viewModel.itemList, [
            const CountryStats.dummy().copyWith(totalCases: 400),
            const CountryStats.dummy().copyWith(totalCases: 3, recovered: 45),
          ]);
        },
      );

      test(
        "Ensure that currentlySelected is assigned first item "
        "when addList(items) called and list is not empty",
        () {
          viewModel.addToList(
            [
              const CountryStats.dummy().copyWith(totalCases: 400),
              const CountryStats.dummy().copyWith(totalCases: 3, recovered: 45),
            ],
          );
          expect(
            viewModel.currentlySelected,
            const CountryStats.dummy().copyWith(totalCases: 400),
          );
        },
      );

      test(
        "Ensure that currentlySelected is NOT assigned first item "
        "when addList(items) called and list IS empty",
        () {
          viewModel.addToList(
            [],
          );
          expect(
            viewModel.currentlySelected,
            null,
          );
        },
      );

      test(
        "Ensure that items are rentained before insertion of new items "
        "when addList(items, clear = false)",
        () {
          viewModel.itemList = [
            const CountryStats.dummy().copyWith(totalCases: 40),
          ];

          viewModel.addToList(
            [
              const CountryStats.dummy().copyWith(totalCases: 400),
              const CountryStats.dummy().copyWith(totalCases: 3, recovered: 45),
            ],
            clear: false,
          );
          expect(viewModel.itemList, [
            const CountryStats.dummy().copyWith(totalCases: 40),
            const CountryStats.dummy().copyWith(totalCases: 400),
            const CountryStats.dummy().copyWith(totalCases: 3, recovered: 45),
          ]);
        },
      );
    },
  );
}
