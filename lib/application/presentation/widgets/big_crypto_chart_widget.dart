import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget bigCryptoChartWidget(final List<double> priceHistory, final int days) {
  final double maxPrice = priceHistory.reduce((final a, final b) => a > b ? a : b);
  final double minPrice = priceHistory.reduce((final a, final b) => a < b ? a : b);
  final double priceInterval = (maxPrice + minPrice) / 2;
  double timeInterval;
  switch (days) {
    case 1:
      timeInterval = 48;
      break;
    case 7:
      timeInterval = 24;
      break;
    case 30:
      timeInterval = 120;
      break;
    default:
      timeInterval = 1;
  }
  return SizedBox(
  height: 200,
  width: double.infinity,
  child: LineChart(
    LineChartData(
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: timeInterval,
            getTitlesWidget: (final value, final meta) {
              int dayLabel = 0;
              switch (days) {
                case 1:
                  dayLabel = ((value / 12).toInt() - 24).abs();
                  break;
                case 7:
                  dayLabel = ((value / 24).toInt() - 7).abs();
                  break;
                case 30:
                  dayLabel = ((value / 24).toInt() - 30).abs();
                  break;
                default:
                  return SideTitleWidget(
                    meta: meta,
                    child: const Text(''),
                  );
              }
              if (dayLabel >= 0 && dayLabel <= 24) {
                return SideTitleWidget(
                  meta: meta,
                  child: Text(dayLabel.toString()),
                );
              } else {
                return SideTitleWidget(
                  meta: meta,
                  child: Text(dayLabel.toString()),
                );
              }
            },
          ),
        ),
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        leftTitles: AxisTitles(
          drawBelowEverything: false,
          sideTitles: SideTitles(
            interval: priceInterval,
            showTitles: true,
            reservedSize: 60,
            )
        )
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: priceHistory
              .asMap()
              .entries
              .map((final entry) => FlSpot(entry.key.toDouble(), entry.value))
              .toList(),
          isCurved: true,
          color: const Color.fromARGB(255, 0, 123, 255),
          belowBarData: BarAreaData(
            show: true,
            color: const Color.fromARGB(100, 0, 123, 255),
          ),
          dotData: const FlDotData(show: false),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (final List<LineBarSpot> touchedSpots) => touchedSpots.map((final spot) => LineTooltipItem(
                'Price: ${spot.y.toStringAsFixed(2)}',
                const TextStyle(color: Colors.white),
              )).toList(),
        ),
      ),
    ),
  ),
);
}