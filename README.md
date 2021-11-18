# covid_example

This is a simple application that shows how i structure my flutter application, how i make api calls ect. Basically shows my coding pattern on projects.

<img src="https://github.com/JasperEssien2/covid_example/blob/master/visuals/WhatsApp%20Video%202021-11-17%20at%2022.15.48.gif" width="300" height="640">

## Table of contents
1. [Getting Started](#getting_started)

2. [Entities Used](#entities_used)
 
3. [Libraries Used](#libraries_used)

4. [Folder Structure](#folder_structure)
    - [Root Level](#folder_structure_root_level)
    - [Business Logic](#folder_structure_business_logic)
    - [Lib](#folder_structure_lib)

5. [Demisifying Business Logic](#demisify_business_logic)

## Getting Started <a name ="getting_started"/>

## How to use

### Step 1
Download or clone this repo by using the link below

[https://github.com/JasperEssien2/covid_example.git](https://github.com/JasperEssien2/covid_example/)

### Step 2
Go to projects root and execute the following command in console to get the required dependencies:

`flutter pub get`

## Entities Used <a name = "entities_used">
* [Design Used](https://dribbble.com/shots/11015463-Covid-19-App-Free)
* [API endpoint](https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/)

## Libraries Used  <a name ="libraries_used"/>
* [Flutter Utilities](https://github.com/JasperEssien2/flutter-utilities.git) Helper in util library, helps in facilitating and making api calls, cubit, viewmodel implementation cleaner and easier
* [Dio](https://pub.dev/packages/dio) For api calls
* [Flutter Bloc](https://pub.dev/packages/flutter_bloc) For app state management
* [Stacked](https://pub.dev/packages/stacked) Handling reactive data
* [GetIt](https://pub.dev/packages/get_it) For dependency injection
* [Fl Chart](https://pub.dev/packages/fl_chart) Used in displayin the barchart
* [Shimmer](https://pub.dev/packages/shimmer) for animation loading state

## Folder Structure  <a name ="folder_structure"/>

### Root level <a name="folder_structure_root_level"/>
> Root folder structure of the app

    covid_example/
    |- android
    |- build
    |- business_logic
    |- ios
    |- lib
    |- test
    
### Business logic <a name = "folder_structure_business_logic"/>
> Contains code relating to logic of the app

    buiness_logic/
    |- lib
    |- cubits
    |    |- features
    |    |_ cubits_export.dart
    |    
    |- di
    |    |_ business_logic_module.dart
    |    |_ service_module.dart
    |    |_ viewmodel_module.dart
    |    
    |- network
    |    |- base
    |        |_endpoints.dart
         |_ helpers
             |_ dio_api_consumer.dart
             |_ dio_requests_helper.dart
             |_ helpers_exports.dart
             
    |    |- models
    |    |- services
    |        |_ feature_service.dart
    |        |_ feature_service_impl.dart
    |    |_ network_export.dart
    |    
    |- viewmodels
    |   |- feature
    |       |_ feature_viewmodel.dart
    |   |_ viewmodel_export.dart
    |    
    |- tests
    |    |-unit_test
    |        |- cubit_test
    |        |- mock
    |        |- view_model_test
 
### lib <a name = "folder_structure_lib"/>
> Contains UI related code

    lib/
    |- di
    |    |_ injector_container.dart
    |- theme
    |    |_ colors.dart
    |- utils
    |    |_ intl_util.dart
    |    |_ widget_utils.dart           (# contains widget components that can be reused, like box-decoration, loading widget, flutter-toast)
    |    |_ utils_export.dart
    
    |- views
    |    |- screens
    |    |    |- feature
    |    |        |-widgets.            (# components used only by the feature)
    |    |        |   |- feature_widget.dart
    |    |
    |    |        |_feature_screens.dart
    |    |
    |    | - shared_components.         (# contains component widget shared accross app)
    
    |    |- app.dart
    |    |- routes.dart (# Contains route names)
    
    |_ main.dart
    
### Demisifying Business Login <a name = "demisify_business_logic"/>
> This section contains documentation of all pratices, structure and helper code used in this codebase, including but not limited to APIs request helpers,  API consumption, cubit helpers, actual cubit implementation, view model helpers, actual view model implementation.

#### Network Section
This section highlights how network calls is being handled.

##### DioRequestHelper
> DioRequestHelper extends from DioHttpHelper, the headers() and interceptors() methods are overidden, the headers is where APIs headers are set. If api calls need to be intercepted, the interceptors method returns a nullable list of interceptors. This class exposes dio GET, POST, PATCH, DELETE request methods.
 
```dart
class DioRequestHelper extends DioHttpHelper {
  @override
  Future<Map<String, String>> get headers async {
    return {
      'x-rapidapi-host':
          'vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com',
      'x-rapidapi-key': dotenv.env['RAPID_KEY'] ?? '',
    };
  }

  @override
  List<Interceptor>? get interceptiors => null;
}
```

##### ApiConsumerHelper
> ApiConsumerHelper extends DioApiConsumption, and implements a mandatory `parseErrorResponse`, this is where error is being parsed from json to `ErrorResponse`. Under the hood, DioApiConsumption handles making the actual api request, checking for success or failures, if the request fails a `RequestFailedException` exception is thrown, if not `SuccessResponse` is returned. This relies on the DioHttpHelper which contains request helper methods (GET, POST, PATCH, DELETE requests).
 

```dart
import 'package:flutter_utilities/utilities.dart';

class ApiConsumerHelper extends DioApiConsumption {
  static ApiConsumerHelper? _instance;

  ApiConsumerHelper._();

  static ApiConsumerHelper get instance {
    _instance ?? ApiConsumerHelper.factory();
    return _instance!;
  }

  ApiConsumerHelper.factory();

  @override
  ErrorResponse parseErrorFromResponse(Response requestResponse) {
    return ErrorResponse(errorMessage: "An error occurred, please try again");
  }
}
```

##### Services file
> The service files follows the OCP (Open Close Principle), and as such has an abstract class and an implementation.
All service methods should return a Future SuccessResponse, it uses the ApiConsumerHelper to handle the actual request, ApiConsumerHelper.simplifyApiRequest() accepts a request function that has a return type of Dio `Response`, a `successResponse` function, which has a json parameter and then returns a `SuccessResponse` object, `simplyApiRequest()` contains other helpful parameters to ease up api implementation, check them out via [Flutter Utilities Documentation](https://github.com/JasperEssien2/flutter-utilities.git). Below contains a sample service method:
 
```dart
 @override
  Future<SuccessResponse> getCountryStatsByCountry(String name, String iso) {
    return ApiConsumerHelper.instance.simplifyApiRequest(
      () => dioHttpHelper.get(covidEndpoints.reportByCountry(name, iso)),
      successResponse: (json) => SuccessResponse(
        (json as List).map((e) => CountryStats.fromJson(e)).toList(),
      ),
    );
  }
```
 
> Handling of these request is simple, traditionally a `try-catch` would do, but there's another helper class created for the purpose of increasing readability. 
```dart 
 HandleRequestResponse.handleResponse<T>(serviceFunc(), response: responseFunc(), error: errorFunction())
 ```
 
> Where T is the object type expected, serviceFunc() is a function that returns a Future `SuccessResponse`, services methods are meant to be passed here, responseFunc(), errorFunction() are functions for handling successful and failed request respectively. Here's a code sample:
 
 ```dart
 void fetchStatsByCountry(String countryName, String iso) {
    emitListLoading();

    HandleRequestResponse.handleResponse<List<CountryStats>>(
      () => service.getCountryStatsByCountry(countryName, iso),
      (response) => _handleSuccessResponse(response),
      (error) => emitListError(error),
    );
  }

  _handleSuccessResponse(SuccessResponse<List<CountryStats>> response) {
    viewModel.addToList(response.value);
    response.value.isEmpty
        ? emit(BaseListEmptyState())
        : emitListLoaded(response.value);
  }
 ```

#### Cubit Section
 > Cubit is a state management by [Flutter Bloc](https://pub.dev/packages/flutter_bloc) For app state management, so this section contains cubit files. In other to avoid some repitive tasks of creating state files for each cubit, [Flutter Utilities](https://github.com/JasperEssien2/flutter-utilities.git), contains some helper abstract classes for simple cubit namely `BaseListCubit<T>` and `BaseObjectCubit` used for cubits emiting a list object and a single object respectively.
 
 > Depending on the use case, either of this class will need to be extended `BaseListCubit<T>` or `BaseObjectCubit<T>`, then you have access to emiting predefine states `[BaseListLoading(), BaseBottomListLoading(), BaseListEmptyState(), BaseListLoaded(), BaseListError(error)]` for `BaseListCubit<T>` and `[BaseObjectLoading(), BaseObjectLoaded(), BaseObjectError(error)]` for `BaseObjectState<T>`. 
 
> I created these helpers after i noticed that following the ~SRP~(Single Responsibilty Principle), i'll have to create lot of cubit files which also includes the states files, to handle a single responsibility, just creating different state files, got so tiring for me and in some way the code became repitive, had to think of a way to abstract and make my work easier and faster. 
 
> This absctraction is limited and cannot account for all cases, but it sure helps in a lot of cases, for the work i've done so far with it.

 ##### Benefits of this abstraction
 * Faster implementation of cubit related files.
 * It's more cleaner and efficient.
 * With this abstraction, i've been able to create a lot of other reusable components like a `PaginatedListView` that can take in different list cubit.
 
 ##### Sample code
 ```dart
 class CountryStatsCubit extends BaseListCubit<CountryStats> {
  final CountriesStatsService service;

  CountryStatsCubit(
      {required this.service, required CountryStatsViewModel viewModel})
      : super(viewModel);

  void fetchStatsByCountry(String countryName, String iso) {
    emitListLoading();

    HandleRequestResponse.handleResponse<List<CountryStats>>(
      () => service.getCountryStatsByCountry(countryName, iso),
      (response) => _handleSuccessResponse(response),
      (error) => emitListError(error),
    );
  }

  _handleSuccessResponse(SuccessResponse<List<CountryStats>> response) {
    viewModel.addToList(response.value);
    response.value.isEmpty
        ? emit(BaseListEmptyState())
        : emitListLoaded(response.value);
  }
}

 ```
