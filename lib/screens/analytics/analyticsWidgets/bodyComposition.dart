import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BodyComposition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    SideTitles _bottomTitles(List<DateTime> dates) {
      return SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) {
          final index = value.toInt();
          if (index < dates.length) {
            var date = dates[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                DateFormat('MMM d').format(date),
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            );
          }
          return Text('');
        },
      );
    }

    List<WeightEntry> weightEntries = generateDummyData();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: screenWidth * 0.94,
        height: screenHeight * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: const Color(0xFFEEEEEE),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: const Color(0xFFEEEEEE),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(sideTitles: _bottomTitles(weightEntries.map((entry) => entry.date).toList())),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: weightEntries.length.toDouble(),
              minY: 0,
              maxY: 80, // Adjust based on your actual data
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    weightEntries.length,
                    (index) {
                      return FlSpot(index.toDouble(), weightEntries[index].weight);
                    },
                  ),
                  isCurved: true,
                  color: Theme.of(context).primaryColor, // Use the theme color for consistency
                  barWidth: 5, // Increase the bar width for better visibility
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<WeightEntry> generateDummyData() {
    Random random = Random();
    List<WeightEntry> entries = [];
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < 10; i++) {
      currentDate = currentDate.subtract(Duration(days: 7));
      double weight = 60 + random.nextDouble() * 10;
      entries.add(WeightEntry(weight: weight, date: currentDate));
    }
    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }
}

class WeightEntry {
  final double weight;
  final DateTime date;

  WeightEntry({required this.weight, required this.date});
}
