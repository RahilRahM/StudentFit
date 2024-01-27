import 'analyticsWidgets/bmi.dart';
import 'package:flutter/material.dart';
import 'analyticsWidgets/separator.dart';
import 'analyticsWidgets/bodyComposition.dart';
import 'package:StudentFit/screens/home/home_widgets/app_bar.dart';
import 'package:StudentFit/screens/home/home_widgets/side_bar.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String selectedTimeframe = 'week';

  void setTimeframe(String timeframe) {
    setState(() {
      selectedTimeframe = timeframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(appBarTitle: "Analytics", actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              BMICalculatorWidget(onTimeframeChanged: setTimeframe),
              separator(),
              const SizedBox(height: 40),
              BodyComposition(timeframe: selectedTimeframe),
            ],
          ),
        ),
      ),
      drawer: buildDrawer(context),
    );
  }
}
