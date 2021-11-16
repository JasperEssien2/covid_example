import 'package:business_logic/business_logic_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fake_services/fake_country_stats_service.dart';

class MockCountryStatsServices extends Mock
    implements FakeCountryStatsServices {}

main() {
  late FakeCountryStatsServices services;
  late MockCountryStatsServices mockedService;
  late CountryStatsCubit countryStatsCubit;

  BaseObjectCubitTestHelper<CountryStatsCubit, CountryStats> testHelper =
      BaseObjectCubitTestHelper<CountryStatsCubit, CountryStats>();

  testHelper.setUp(
    () {
      services = FakeCountryStatsServices();
      mockedService = MockCountryStatsServices();
      countryStatsCubit = CountryStatsCubit(service: services);
    },
  );

  testHelper.setup();

  group(
    "Test fetchStatsByCountryCode()",
    () {
      group(
        "Test logic",
        () {
          testHelper.testBaseObjectSuccess(
            whenText:
                " fetchStatsByCountryCode() called and request was successful",
            build: () => countryStatsCubit,
            act: (cubit) => cubit.fetchStatsByCountryCode('NG'),
            verify: (cubit) => null,
            objectExpected: const CountryStats.dummy(),
          );

          testHelper.testBaseObjectError(
            whenText: " fetchStatsByCountryCode() called and request failed",
            build: () {
              services.returnSucces = false;
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchStatsByCountryCode('NG'),
            verify: (cubit) => null,
            error: "An error occurred",
          );
        },
      );

      group(
        "Test api calls",
        () {
          testHelper.testBaseObjectSuccess(
            whenText:
                " fetchStatsByCountryCode() called and request was successful "
                "Ensure country code is passed to service.getLatestCountryDataByCode()",
            build: () {
              _setupMockedService(mockedService);
              countryStatsCubit = CountryStatsCubit(service: mockedService);
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchStatsByCountryCode('NG'),
            verify: (cubit) =>
                verify(() => mockedService.getLatestCountryDataByCode("NG")),
            objectExpected: const CountryStats.dummy(),
          );
        },
      );
    },
  );

  group(
    "Test fetchStatsByCountryName()",
    () {
      group(
        "Test logic",
        () {
          testHelper.testBaseObjectSuccess(
            whenText:
                " fetchStatsByCountryName() called and request was successful",
            build: () => countryStatsCubit,
            act: (cubit) => cubit.fetchStatsByCountryName('Nigeria'),
            verify: (cubit) => null,
            objectExpected: const CountryStats.dummy(),
          );

          testHelper.testBaseObjectError(
            whenText: " fetchStatsByCountryName() called and request failed",
            build: () {
              services.returnSucces = false;
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchStatsByCountryName('Nigeria'),
            verify: (cubit) => null,
            error: "An error occurred",
          );
        },
      );

      group(
        "Test api calls",
        () {
          testHelper.testBaseObjectSuccess(
            whenText:
                " fetchStatsByCountryName() called and request was successful "
                "Ensure country name is passed to service.getLatestCountryDataByName()",
            build: () {
              _setupMockedService(mockedService);
              countryStatsCubit = CountryStatsCubit(service: mockedService);
              return countryStatsCubit;
            },
            act: (cubit) => cubit.fetchStatsByCountryName('Nigeria'),
            verify: (cubit) => verify(
                () => mockedService.getLatestCountryDataByName("Nigeria")),
            objectExpected: const CountryStats.dummy(),
          );
        },
      );
    },
  );
}

void _setupMockedService(MockCountryStatsServices mockedService) {
  when(() => mockedService.getLatestCountryDataByCode(any())).thenAnswer(
      (_) => Future.value(SuccessResponse(const CountryStats.dummy())));

  when(() => mockedService.getLatestCountryDataByName(any())).thenAnswer(
      (_) => Future.value(SuccessResponse(const CountryStats.dummy())));
}
