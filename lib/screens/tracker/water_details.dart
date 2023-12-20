import 'calories_details.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../welcomePages/widgets/widgets.dart';
import 'package:student_fit/constants/endpoints.dart';
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
  String userId =
      'user123'; // Replace with your actual logic to get the user's ID after login

  @override
  void initState() {
    super.initState();
    // Fetch water intake history when the page is initialized
    fetchWaterIntakeHistory();
  }

  Future<void> fetchWaterIntakeHistory() async {
    try {
      // Send a GET request to fetch water intake history for the user
      var response = await http
          .get(Uri.parse('$apiEndpointUserInsertWaterIntake?user_id=$userId'));

      if (response.statusCode == 200) {
        // Parse the response body and update the waterIntakeHistory list
        List<dynamic> data = response.body as List<dynamic>;
        setState(() {
          waterIntakeHistory = List<Map<String, dynamic>>.from(data);
        });
      } else {
        // Handle errors here
        print(
            'Failed to fetch water intake history. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching water intake history: $e');
    }
  }

  Future<void> sendWaterIntakeToServer(
      String userId, double waterIntake) async {
    try {
      // Assuming apiEndpointUserInsertWaterIntake is a String
      String apiEndpointUserInsertWaterIntakeString =
          'https://vercel-test-snowy-chi.vercel.app/users.insertWaterIntake';

// Convert the String URL to a Uri object
      Uri apiEndpointUserInsertWaterIntake =
          Uri.parse(apiEndpointUserInsertWaterIntakeString);

// Then, in your code, use it like this:
      var response = await http.post(
        apiEndpointUserInsertWaterIntake,
        body: {
          'user_id': userId,
          'water_intake': waterIntake.toString(),
        },
      );

      // Handle the response as needed
      print('Server response: ${response.body}');

      // Fetch updated water intake history after recording
      await fetchWaterIntakeHistory();
    } catch (e) {
      print('Error recording water intake: $e');
    }
  }

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
                    onPressed: () async {
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

                        // Send water intake data to the server
                        sendWaterIntakeToServer(userId, waterIntake);
                      });
                    },
                    child: const Text('Add Cup of Water'),
                  ),

                  // Your existing code

                  // Display fetched water intake history
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: waterIntakeHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text('Date: ${waterIntakeHistory[index]['date']}'),
                        subtitle: Text(
                            'Water Intake: ${waterIntakeHistory[index]['intake']} ml'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
