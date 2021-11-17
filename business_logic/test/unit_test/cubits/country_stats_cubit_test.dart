import 'package:business_logic/business_logic_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fake_services/fake_country_stats_service.dart';

class MockCountryStatsServices extends Mock
    implements FakeCountryStatsServices {}

main() {
  late FakeCountryStatsServices services;
  late MockCountryStatsServices mockedService;
  late CountryStatsViewModel viewModel;
  late CountryStatsCubit countryStatsCubit;

  BaseListCubitTestHelper<CountryStatsCubit, CountryStats> testHelper =
      BaseListCubitTestHelper<CountryStatsCubit, CountryStats>();

  testHelper.setUp(
    () {
      services = FakeCountryStatsServices();
      viewModel = CountryStatsViewModel();
      mockedService = MockCountryStatsServices();
      countryStatsCubit =
          CountryStatsCubit(service: services, viewModel: viewModel);
    },
  );

  testHelper.setup();

  group(
    "Test fetchStatsByCountryCode()",
    () {
      group(
        "Test logic",
        () {
          testHelper.testBaseListLoadingEmptySuccess(
            whenText:
                " fetchStatsByCountry() called and request was successful",
            build: () {
              services.dataToReturn = [];
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchStatsByCountry('Nigeria', "NGA"),
            verify: (cubit) => null,
            viewModelListExpected: [],
          );

          testHelper.testInitialBaseListSuccess(
            whenText:
                " fetchStatsByCountryCode() called and request was successful",
            build: () => countryStatsCubit,
            act: (cubit) => cubit.fetchStatsByCountry('Nigeria', "NGA"),
            verify: (cubit) => null,
            viewModelListExpected: _dummyCountryList,
            cubitListExpected: _dummyCountryList,
          );

          testHelper.testInitialBaseListError(
            whenText: " fetchStatsByCountry() called and request failed",
            build: () {
              services.returnSucces = false;
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchStatsByCountry('Nigeria', "NG"),
            verify: (cubit) => null,
            error: "An error occurred",
          );
        },
      );

      group(
        "Test api calls",
        () {
          testHelper.testInitialBaseListSuccess(
            whenText:
                " fetchStatsByCountryCode() called and request was successful"
                "Ensure country name and iso is passed to service.getCountryStatsByCountry() ",
            build: () {
              _setupMockedService(mockedService);
              countryStatsCubit = CountryStatsCubit(
                  service: mockedService, viewModel: viewModel);
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchStatsByCountry('Nigeria', "NGA"),
            verify: (cubit) => verify(
                () => mockedService.getCountryStatsByCountry("Nigeria", "NGA")),
            viewModelListExpected: _dummyCountryList,
            cubitListExpected: _dummyCountryList,
          );
        },
      );
    },
  );

  group(
    "Test fetchSixMonthsStatsByCountry()",
    () {
      group(
        "Test logic",
        () {
          testHelper.testBaseListLoadingEmptySuccess(
            whenText:
                " fetchSixMonthsStatsByCountry() called and request was successful",
            build: () {
              services.dataToReturn = [];
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchSixMonthsStatsByCountry("NGA"),
            verify: (cubit) => null,
            viewModelListExpected: [],
          );

          testHelper.testInitialBaseListSuccess(
            whenText:
                " fetchSixMonthsStatsByCountry() called and request was successful",
            build: () => countryStatsCubit,
            act: (cubit) => cubit.fetchSixMonthsStatsByCountry("NGA"),
            verify: (cubit) => null,
            viewModelListExpected: _dummyCountryList,
            cubitListExpected: _dummyCountryList,
          );

          testHelper.testInitialBaseListError(
            whenText:
                " fetchSixMonthsStatsByCountry() called and request failed",
            build: () {
              services.returnSucces = false;
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchSixMonthsStatsByCountry("NG"),
            verify: (cubit) => null,
            error: "An error occurred",
          );
        },
      );

      group(
        "Test api calls",
        () {
          testHelper.testInitialBaseListSuccess(
            whenText:
                " fetchSixMonthsStatsByCountry() called and request was successful"
                "Ensure country iso is passed to service.getSixMonthsCountryStatsByCountry() ",
            build: () {
              _setupMockedService(mockedService);
              countryStatsCubit = CountryStatsCubit(
                  service: mockedService, viewModel: viewModel);
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchSixMonthsStatsByCountry("NGA"),
            verify: (cubit) => verify(
                () => mockedService.getSixMonthsCountryStatsByCountry("NGA")),
            viewModelListExpected: _dummyCountryList,
            cubitListExpected: _dummyCountryList,
          );
        },
      );
    },
  );

  group(
    "Test getTotalAndDeathStatistics()",
    () {
      test(
        "Ensure that entries with in the format of month: (total cases, deaths) "
        "Ensure that entries with same month is summed up (total cases, deaths) "
        "when getTotalAndDeathStatistics() called and list is not empty",
        () {
          viewModel.itemList = _dummyCountryListForStats;

          expect(countryStatsCubit.getTotalAndDeathStatistics(), {
            "Oct": {60, 5},
            "Nov": {210, 450},
          });
        },
      );

      test(
        "Ensure that maps returns empty  when date of an entry is null",
        () {
          viewModel.itemList = _dummyCountryList;

          expect(countryStatsCubit.getTotalAndDeathStatistics(), {});
        },
      );

      test(
        "Ensure that maps returns empty  when itemList is emptu",
        () {
          viewModel.itemList = [];

          expect(countryStatsCubit.getTotalAndDeathStatistics(), {});
        },
      );
    },
  );
}

List<CountryStats> get _dummyCountryList => const [CountryStats.dummy()];

List<CountryStats> get _dummyCountryListForStats => [
      const CountryStats.dummy()
          .copyWith(deaths: 400, totalCases: 200, date: "2021-11-5"),
      const CountryStats.dummy()
          .copyWith(deaths: 50, totalCases: 10, date: "2021-11-15"),
      const CountryStats.dummy()
          .copyWith(deaths: 5, totalCases: 60, date: "2021-10-2"),
    ];

void _setupMockedService(MockCountryStatsServices mockedService) {
  when(() => mockedService.getCountryStatsByCountry(any(), any()))
      .thenAnswer((_) => Future.value(SuccessResponse(_dummyCountryList)));

  when(() => mockedService.getSixMonthsCountryStatsByCountry(any()))
      .thenAnswer((_) => Future.value(SuccessResponse(_dummyCountryList)));
}
