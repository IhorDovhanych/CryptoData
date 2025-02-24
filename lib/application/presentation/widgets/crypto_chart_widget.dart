import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget cryptoChartWidget(final List<double> priceHistory) => SizedBox(
      height: 50,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(),
            rightTitles: AxisTitles(),
            bottomTitles: AxisTitles(),
            topTitles: AxisTitles()
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
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
              dotData: const FlDotData(show: false)
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
