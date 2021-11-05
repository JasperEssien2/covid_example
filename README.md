# covid_example

This is a simple application that shows how i structure my flutter application, how i make api calls ect. Basically shows my coding pattern on projects

## Table of contents
1. [Getting Started](#getting_started)
 
2. [Libraries Used](#libraries_used)

3. [Folder Structure](#folder_structure)
    - [Root Level](#folder_structure_root_level)
    - [Business Logic](#folder_structure_business_logic)
    - [Lib](#folder_structure_lib)

4. [Demisifying Business Logic](#demisify_business_logic)

## Getting Started <a name ="getting_started"/>

## How to use

### Step 1
Download or clone this repo by using the link below

[https://github.com/JasperEssien2/covid_example.git](https://github.com/JasperEssien2/covid_example/)

### Step 2
Go to projects root and execute the following command in console to get the required dependencies:

`flutter pub get`

## Libraries Used  <a name ="libraries_used"/>
* [Flutter Utilities](https://github.com/JasperEssien2/flutter-utilities.git) Making api calls, cubit, viewmodel and storage implementation cleaner and easier
* [Dio](https://pub.dev/packages/dio) For api calls
* [Flutter Bloc](https://pub.dev/packages/flutter_bloc) For app state management
* [Stacked](https://pub.dev/packages/stacked) Handling reactive data
* [SharedPreference](https://pub.dev/packages/shared_preferences) for shared preference
* [GetIt](https://pub.dev/packages/get_it) For dependency injection
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
    |    |_ home_widget_util.dart       (# contains logic determining home widget)
    |    |_ image_util.dart             (# contains all image assets assigned to variables)
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
> This section contains documentation of all pratices, structure and helper code used in this codebase, including but not limited to api consumption helpers, actual api consumption, cubit helpers, actual cubit implementation, view model helpers, actual view model implementation.
