import 'package:business_logic/business_logic_export.dart';
import 'package:covid_example/di/di_injector_container.dart';
import 'package:covid_example/theme/colors.dart';
import 'package:covid_example/views/utils/item_model.dart';
import 'package:covid_example/views/widget/item_stats_card.dart';
import 'package:covid_example/views/widget/item_tab.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final countryStatsCubit = injector.get<CountryStatsCubit>();
  final countrySixMonthStatsCubit = injector.get<CountryStatsCubit>();

  @override
  void initState() {
    countryStatsCubit.fetchStatsByCountry("Nigeria", "NGA");
    countrySixMonthStatsCubit.fetchSixMonthsStatsByCountry("NGA");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: BlocProvider<CountryStatsCubit>(
            create: (context) => countryStatsCubit,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                _AppBar(),
                ItemTabWidget(),
                _DayTabWidget(),
                Flexible(child: _StatisticsWidget()),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BlocProvider<CountryStatsCubit>(
        create: (context) => countrySixMonthStatsCubit,
        child: BottomSheet(
          enableDrag: false,
          onClosing: () {},
          constraints: BoxConstraints(maxHeight: size.height * 0.4),
          builder: (c) {
            var totalAndDeathMap =
                countrySixMonthStatsCubit.getTotalAndDeathStatistics();
            var keys = totalAndDeathMap.keys.toList();
            return Container(
              child: BarChart(
                BarChartData(
                  backgroundColor: Colors.white,
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (val) {
                        return keys[val.toInt()];
                      },
                    ),
                  ),
                  barGroups: keys
                      .map(
                        (e) => BarChartGroupData(
                          x: keys.indexOf(e),
                          barRods: [
                            BarChartRodData(
                              y: (totalAndDeathMap[e]?.elementAt(0) ?? 0)
                                  .toDouble(),
                            ),
                            BarChartRodData(
                              y: (totalAndDeathMap[e]?.elementAt(1) ?? 0)
                                  .toDouble(),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),

                swapAnimationDuration:
                    const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.menu,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.notifications_active_outlined,
                size: 24,
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            "Statistics",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _DayTabWidget extends StatelessWidget {
  const _DayTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: _dayTabWidgets(),
        ),
      ),
    );
  }

  List<Widget> _dayTabWidgets() {
    return List.generate(
      3,
      (index) {
        String text = '';
        bool isSelected = false;
        switch (index) {
          case 0:
            text = "Total";
            isSelected = true;
            break;
          case 1:
            text = "Today";
            break;
          case 2:
            text = "Yesterday";
            break;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : textColorUnselected,
            ),
          ),
        );
      },
    );
  }
}

class _StatisticsWidget
    extends ViewModelBuilderWidget<ListBaseViewModel<CountryStats>> {
  const _StatisticsWidget({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context,
      ListBaseViewModel<CountryStats> viewModel, Widget? child) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).copyWith(
        bottom: size.height * 0.42,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ItemStatsCard(
                    itemModel: _statisticsItems(context)[0],
                  ),
                ),
                Expanded(
                  child: ItemStatsCard(
                    itemModel: _statisticsItems(context)[1],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ItemStatsCard(
                    itemModel: _statisticsItems(context)[2],
                  ),
                ),
                Expanded(
                  child: ItemStatsCard(
                    itemModel: _statisticsItems(context)[3],
                  ),
                ),
                Expanded(
                  child: ItemStatsCard(
                    itemModel: _statisticsItems(context)[4],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get disposeViewModel => false;

  @override
  ListBaseViewModel<CountryStats> viewModelBuilder(BuildContext context) =>
      BlocProvider.of<CountryStatsCubit>(context).viewModel;

  List<ItemModel> _statisticsItems(BuildContext context) {
    final currentlySelected = viewModelBuilder(context).currentlySelected;
    final state =
        BlocProvider.of<CountryStatsCubit>(context, listen: true).state;

    bool isLoading = state is BaseListLoading;

    return [
      ItemModel(
          caption: "Affected",
          value: currentlySelected?.totalCases.toString() ?? 'N/A',
          isLoading: isLoading,
          color: colorAffected),
      ItemModel(
          caption: "Death",
          value: currentlySelected?.deaths.toString() ?? 'N/A',
          isLoading: isLoading,
          color: colorDeaths),
      ItemModel(
          caption: "Recovered",
          value: currentlySelected?.recovered.toString() ?? 'N/A',
          isLoading: isLoading,
          color: colorRecovered),
      ItemModel(
          caption: "Active",
          value: currentlySelected?.active.toString() ?? 'N/A',
          isLoading: isLoading,
          color: colorActive),
      ItemModel(
          caption: currentlySelected?.critical.toString() ?? "Serios",
          value: 'N/A',
          isLoading: isLoading,
          color: colorSerious),
    ];
  }
}
