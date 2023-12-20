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
          if (value.toInt() < dates.length) {
            var date = dates[value.toInt()];
            return SideTitleWidget(axisSide: meta.axisSide, child: Text(DateFormat('MMM d').format(date)));
          }
          return const SizedBox.shrink(); 
        },
      );
    }


    List<WeightEntry> generateDummyData() {
      // Generate dummy weight entries
      Random random = Random();
      List<WeightEntry> entries = [];
      DateTime currentDate = DateTime.now();
      for (int i = 0; i < 10; i++) {
        currentDate = currentDate.subtract(Duration(days: 7)); // One week apart
        double weight = 60 + random.nextDouble() * 10; // Random weight between 60 and 70
        entries.add(WeightEntry(weight: weight, date: currentDate));
      }
      return entries;
    }

    List<WeightEntry> weightEntries = generateDummyData();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: screenWidth * 0.94,
        height: screenHeight * 0.3,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // title row
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Body Composition',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  'View more',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF1F73F1),
                    fontSize: 10,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            // statistics
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: _bottomTitles(weightEntries.map((entry) => entry.date).toList())),
                  ),
                  borderData: FlBorderData(show: true),
                  clipData: FlClipData.all(),
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
                      color: Colors.blue, // You can change the color
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeightEntry {
  final double weight;
  final DateTime date;

  WeightEntry({required this.weight, required this.date});
}