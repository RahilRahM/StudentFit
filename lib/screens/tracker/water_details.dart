import 'package:flutter/material.dart';
import 'package:StudentFit/commons/index.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:StudentFit/screens/home/home_widgets/app_bar.dart';

class WaterPage extends StatefulWidget {
  @override
  _WaterPageState createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  final double goal = 3000.0; // Daily water intake goal in ml
  double waterIntake = 0.0;
  List<String> intakeHistory = [];
  double defaultCupSize = 250.0; // Default cup size
  bool goalAchievedMessageShown = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      waterIntake = prefs.getDouble('waterIntake') ?? 0.0;
      intakeHistory = prefs.getStringList('intakeHistory') ?? [];
      defaultCupSize = prefs.getDouble('cupSize') ?? defaultCupSize;
    });
    if (prefs.getString('date') !=
        DateTime.now().toIso8601String().substring(0, 10)) {
      goalAchievedMessageShown = false;
    }
  }

  Future<void> _updateWaterIntake(double intake) async {
    final prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String timestamp =
        "${now.toIso8601String().substring(0, 10)} ${now.hour}:${now.minute}";

    setState(() {
      waterIntake += intake;
      intakeHistory.add("$timestamp: $intake ml");
    });

    await prefs.setDouble('waterIntake', waterIntake);
    await prefs.setStringList('intakeHistory', intakeHistory);

    _checkAndShowGoalAchievement(); // Moved inside setState to ensure waterIntake is updated
  }

  void _checkAndShowGoalAchievement() {
    if (waterIntake >= goal && !goalAchievedMessageShown) {
      goalAchievedMessageShown = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              'Great Job!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 24,
              ),
            ),
            content: Text(
              'You have reached your daily water intake goal of $goal ml!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Continue', style: TextStyle(color: Colors.indigo)),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildWaterIntakeIndicator() {
    return CircularPercentIndicator(
      radius: 120.0,
      lineWidth: 13.0,
      animation: true,
      percent: waterIntake / goal > 1.0 ? 1.0 : waterIntake / goal,
      center: Text(
        "${waterIntake.toStringAsFixed(0)} ml",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppColors.primaryColor,
    );
  }

  Widget _buildCupSizeDropdown() {
    return DropdownButton<double>(
      value: defaultCupSize,
      onChanged: (newValue) {
        setState(() {
          defaultCupSize = newValue ?? defaultCupSize;
        });
        _saveCupSize(defaultCupSize);
      },
      items: <double>[250.0, 500.0, 750.0]
          .map<DropdownMenuItem<double>>((double value) {
        return DropdownMenuItem<double>(
          value: value,
          child: Text("${value.toInt()}ml Cup"),
        );
      }).toList(),
    );
  }

  Future<void> _saveCupSize(double cupSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('cupSize', cupSize);
  }

  Widget _buildAddWaterButton() {
    return ElevatedButton.icon(
      onPressed: () => _updateWaterIntake(defaultCupSize),
      icon: Icon(Icons.local_drink, color: Colors.white),
      label: Text('Add ${defaultCupSize.toInt()}ml',
          style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  Widget _buildIntakeHistory() {
    return ExpansionTile(
      title: Text('Intake History'),
      children: [
        Container(
          height: 350, // Adjust this height as necessary
          child: SingleChildScrollView(
            child: Column(
              children: intakeHistory
                  .map((record) => ListTile(title: Text(record)))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Water intake',
        showFavoriteIcon: false,
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildWaterIntakeIndicator(),
              SizedBox(height: 20),
              _buildCupSizeDropdown(),
              SizedBox(height: 20),
              _buildAddWaterButton(),
              SizedBox(height: 20),
              _buildIntakeHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
