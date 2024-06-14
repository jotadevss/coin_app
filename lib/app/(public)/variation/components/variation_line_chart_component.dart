import 'package:coin_app/app/interactor/models/variation.dart';
import 'package:coin_app/app/shared/formatters/currency_formatter.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartVariation extends StatelessWidget {
  const LineChartVariation({
    super.key,
    required this.valuesInRangeToChart,
    required this.variations,
    required this.valuesVariationToChart,
  });

  final List<double> valuesInRangeToChart;
  final List<double> valuesVariationToChart;
  final List<Variation> variations;

  // Box spot indicator style
  List<TouchedSpotIndicatorData?> _getTouchedSpotIndicator(LineChartBarData barData, List<int> spotIndexes) {
    return spotIndexes.map((_) {
      return TouchedSpotIndicatorData(
        const FlLine(
          color: AppStyle.kPrimaryColor,
          dashArray: [4],
        ),
        FlDotData(getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            color: AppStyle.kPrimaryColor,
            strokeColor: AppStyle.kPrimaryColor,
            radius: 8,
          );
        }),
      );
    }).toList();
  }

  // Spots
  List<FlSpot> get getSpots {
    final spots = <FlSpot>[];
    final values = valuesInRangeToChart;

    if (values.isEmpty) {
      for (var i = 0; i < 15; i++) {
        final spot = FlSpot(i.toDouble() + 1, 2.5);
        spots.add(spot);
      }
      return spots;
    }

    for (var i = 0; i < values.length; i++) {
      final spot = FlSpot(i.toDouble() + 1, values[i]);
      spots.add(spot);
    }

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    // Widgets
    final getBottonTitles = AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 8,
        getTitlesWidget: (value, meta) {
          final index = (value - 1).round();
          final datetime = (variations.isEmpty) ? DateTime.now() : variations[index].date;
          final formatter = DateFormat("dd/MMM");
          final title = formatter.format(datetime);

          final textWidget = Text(
            title,
            style: const TextStyle(
              color: AppStyle.kGrayFontColor,
              fontSize: 12,
            ),
          );

          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 12,
            fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
            child: textWidget,
          );
        },
      ),
    );

    final getLeftTitles = AxisTitles(
      sideTitles: SideTitles(
        reservedSize: 55,
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) {
          final title = (valuesVariationToChart.isEmpty ? 0.0 : valuesVariationToChart[value.toInt() - 1]);
          final formattedTitle = CurrencyFormatter.formatSimple(title);

          final textWidget = Text(
            formattedTitle,
            style: const TextStyle(
              color: AppStyle.kGrayFontColor,
              fontSize: 12,
            ),
          );

          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 8,
            fitInside: SideTitleFitInsideData.fromTitleMeta(meta, distanceFromEdge: 2),
            child: textWidget,
          );
        },
      ),
    );

    return SizedBox(
      height: 240,
      width: double.infinity,
      child: LineChart(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
        LineChartData(
          minX: 1,
          maxX: 15,
          minY: 1,
          maxY: 4,
          lineTouchData: LineTouchData(
            getTouchedSpotIndicator: _getTouchedSpotIndicator,
            touchTooltipData: LineTouchTooltipData(
              fitInsideHorizontally: true,
              tooltipBgColor: const Color(0xFFF5F5F5),
              tooltipBorder: BorderSide(color: Colors.grey.withOpacity(0.3)),
              tooltipRoundedRadius: 8,
              getTooltipItems: (touchedBarSpots) {
                final lineTooltipItems = <LineTooltipItem?>[];

                for (var i = 0; i < touchedBarSpots.length; i++) {
                  Variation variation = variations[touchedBarSpots[i].spotIndex];

                  String text = "${CurrencyFormatter.format((variation.value * 100).toString())} \n";

                  final toolTipItem = LineTooltipItem(
                      text,
                      const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: DateFormat("dd/MMM").format(variation.date),
                          style: const TextStyle(
                            color: AppStyle.kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ]);

                  lineTooltipItems.add(toolTipItem);
                }

                return lineTooltipItems;
              },
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: getLeftTitles,
            bottomTitles: getBottonTitles,
          ),
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
                dashArray: [3],
              );
            },
            checkToShowHorizontalLine: (value) => true,
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide.none,
              right: BorderSide.none,
              bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
              top: BorderSide(color: Colors.grey.withOpacity(0.1)),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              barWidth: 3,
              color: AppStyle.kPrimaryColor,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.mirror,
                  colors: [
                    AppStyle.kPrimaryColor.withOpacity(0.5),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
              spots: getSpots,
            )
          ],
        ),
      ),
    );
  }
}
