import 'calories_details.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../welcomePages/widgets/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaterPage extends StatefulWidget {
  @override
  _WaterPageState createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  double waterIntake = 0;
  double goal = 2000;
  double previousTotal = 0;
  List<Map<String, dynamic>> waterIntakeHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: 'Water Details',
                onBack: () {
                  Navigator.pop(context);
                },
                onForward: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CaloriesDetailPage(
                        recipeData: {
                          'path': 'assets/images/snack1.jpeg',
                          'title': 'Healthy Salad',
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Daily Goal: ${goal.toStringAsFixed(2)} ml',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircularPercentIndicator(
                    radius: 180.0,
                    lineWidth: 15.0,
                    percent:
                        waterIntake / goal > 1.0 ? 1.0 : waterIntake / goal,
                    center: Text(
                      '${(waterIntake + previousTotal).toStringAsFixed(2)} ml',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    progressColor:
                        waterIntake >= goal ? Colors.green : Colors.blue,
                    backgroundColor:
                        waterIntake >= goal ? Colors.blue : Colors.grey,
                  ),
                  const SizedBox(height: 25.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        waterIntake += 240;
                        if (waterIntake >= goal) {
                          previousTotal += waterIntake;
                          waterIntake = 0;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Congratulations! You reached your daily water intake goal. Stay hydrated!'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {},
                              ),
                            ),
                          );
                        }
                        waterIntakeHistory.add({
                          'date': DateTime.now().toString(),
                          'intake': waterIntake,
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Add Cup of Water',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Set Custom Goal (ml)',
                      contentPadding: EdgeInsets.only(
                          left: 16.0), // Adjust the left margin as needed
                    ),
                    onChanged: (value) {
                      setState(() {
                        goal = double.parse(value);
                      });
                    },
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: waterIntakeHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Date: ${waterIntakeHistory[index]['date']}'),
                    subtitle: Text(
                        'Water Intake: ${waterIntakeHistory[index]['intake']} ml'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
