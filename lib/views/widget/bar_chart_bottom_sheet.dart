import 'package:business_logic/business_logic_export.dart';
import 'package:covid_example/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartBottomSheet extends StatelessWidget {
  const BarChartBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CountryStatsCubit, BaseListState>(
      builder: (context, state) {
        var totalAndDeathMap = BlocProvider.of<CountryStatsCubit>(context)
            .getTotalAndDeathStatistics();

        return BottomSheet(
          enableDrag: false,
          onClosing: () {},
          constraints: BoxConstraints(maxHeight: size.height * 0.4),
          builder: (c) {
            var keys = totalAndDeathMap.keys.toList();
            return Padding(
              padding: const EdgeInsets.all(12.0).copyWith(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: BarChart(
                      BarChartData(
                        axisTitleData: _axisTitle(),
                        gridData: FlGridData(
                            drawHorizontalLine: true,
                            getDrawingHorizontalLine: (_) => FlLine(
                                color: Colors.grey[200], strokeWidth: 0.5)),
                        backgroundColor: Colors.white,
                        borderData: FlBorderData(show: false),
                        titlesData: _title(keys),
                        barGroups: keys
                            .map(
                              (e) => BarChartGroupData(
                                x: keys.indexOf(e),
                                barRods: [
                                  BarChartRodData(
                                      y: (totalAndDeathMap[e]?.elementAt(0) ??
                                              0)
                                          .toDouble(),
                                      colors: [colorAffected]),
                                ],
                              ),
                            )
                            .toList(),
                      ),

                      swapAnimationDuration:
                          const Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    ),
                  ),
                  if (state is BaseListLoading) const LinearProgressIndicator(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  FlAxisTitleData _axisTitle() {
    return FlAxisTitleData(
      topTitle: AxisTitle(
        showTitle: true,
        textAlign: TextAlign.left,
        titleText: "Monthly Cases NGA",
        margin: 12,
        textStyle: _titleTextStyle().copyWith(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  FlTitlesData _title(List<String> keys) {
    return FlTitlesData(
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (_, __) => _titleTextStyle(),
      ),
      bottomTitles: SideTitles(
        showTitles: true,
        getTitles: (val) {
          return keys[val.toInt()];
        },
        getTextStyles: (_, __) => _titleTextStyle(),
      ),
    );
  }

  TextStyle _titleTextStyle() =>
      const TextStyle(fontSize: 12, color: Colors.black45);
}
