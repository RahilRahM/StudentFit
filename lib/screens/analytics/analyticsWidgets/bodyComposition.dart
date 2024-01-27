import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyComposition extends StatefulWidget {
  final String timeframe;

  const BodyComposition({Key? key, required this.timeframe}) : super(key: key);

  @override
  _BodyCompositionState createState() => _BodyCompositionState();
}

class _BodyCompositionState extends State<BodyComposition> {
  List<WeightEntry> weightEntries = [];
  List<WeightEntry> displayedEntries = [];

  @override
  void initState() {
    super.initState();
    loadWeightData();
  }

  @override
  void didUpdateWidget(covariant BodyComposition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.timeframe != oldWidget.timeframe) {
      filterDataBasedOnTimeframe(widget.timeframe);
    }
  }

  void loadWeightData() async {
    final prefs = await SharedPreferences.getInstance();
    String? weightRecordsString = prefs.getString('weight_records');
    if (weightRecordsString != null) {
      List<dynamic> records = jsonDecode(weightRecordsString);
      weightEntries = records.map((record) {
        return WeightEntry(
          weight: record['weight'].toDouble(),
          date: DateTime.parse(record['timestamp']),
        );
      }).toList();
      filterDataBasedOnTimeframe(widget.timeframe);
    }
  }

  void filterDataBasedOnTimeframe(String timeframe) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (timeframe) {
      case 'week':
        startDate = now.subtract(Duration(days: now.weekday - 1));
        displayedEntries = weightEntries.where((entry) => entry.date.isAfter(startDate)).toList();
        break;
      case 'month':
        startDate = DateTime(now.year, now.month, 1);
        displayedEntries = _groupEntriesByDay();
        break;
      case 'year':
        startDate = DateTime(now.year, 1, 1);
        displayedEntries = _groupEntriesByMonth();
        break;
      default:
        startDate = now.subtract(Duration(days: 30)); // Default to last 30 days
        displayedEntries = weightEntries.where((entry) => entry.date.isAfter(startDate)).toList();
        break;
    }

    setState(() {});
  }

List<WeightEntry> _groupEntriesByDay() {
  Map<int, List<WeightEntry>> dayMap = {};
  for (var entry in weightEntries) {
    int day = DateTime(entry.date.year, entry.date.month, entry.date.day).millisecondsSinceEpoch;
    dayMap.putIfAbsent(day, () => []).add(entry);
  }
  return dayMap.entries.map((entry) {
    double avgWeight = entry.value.fold<double>(0, (sum, e) => sum + e.weight) / entry.value.length;
    return WeightEntry(weight: avgWeight, date: DateTime.fromMillisecondsSinceEpoch(entry.key));
  }).toList();
}

List<WeightEntry> _groupEntriesByMonth() {
  Map<int, List<WeightEntry>> monthMap = {};
  for (var entry in weightEntries) {
    int month = DateTime(entry.date.year, entry.date.month).millisecondsSinceEpoch;
    monthMap.putIfAbsent(month, () => []).add(entry);
  }
  return monthMap.entries.map((entry) {
    double avgWeight = entry.value.fold<double>(0, (sum, e) => sum + e.weight) / entry.value.length;
    return WeightEntry(weight: avgWeight, date: DateTime.fromMillisecondsSinceEpoch(entry.key));
  }).toList();
}


  double getMinY() {
    if (displayedEntries.isEmpty) return 0;
    double minWeight = displayedEntries.map((e) => e.weight).reduce(min);
    return minWeight - 10;
  }

  double getMaxY() {
    if (displayedEntries.isEmpty) return 100;
    double maxWeight = displayedEntries.map((e) => e.weight).reduce(max);
    return maxWeight + 10;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEEEEEE), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Body Composition (BMI changes)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: LineChart(
                  LineChartData(
                    minY: getMinY(),
                    maxY: getMaxY(),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: const Color(0xFFEAEAEA),
                        strokeWidth: 1,
                      ),
                      drawVerticalLine: false,
                    ),
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            final date = displayedEntries[value.toInt()].date;
                            switch (widget.timeframe) {
                              case 'week':
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(DateFormat('E').format(date)), // Shows day of week
                                );
                              case 'month':
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(DateFormat('d').format(date)), // Shows day of month
                                );
                              case 'year':
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(DateFormat('MMM').format(date)), // Shows month
                                );
                              default:
                                return Text(''); // Default case
                            }
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value == 50) {
                              return Text('50', style: TextStyle(color: Colors.green));
                            } else if (value == 80) {
                              return Text('80', style: TextStyle(color: Colors.red));
                            }
                            return Text('');
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: displayedEntries.asMap().entries.map((entry) {
                          return FlSpot(entry.key.toDouble(), entry.value.weight);
                        }).toList(),
                        isCurved: true,
                        color: Colors.blue,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
