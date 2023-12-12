import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import 'package:student_fit/commons/button.dart';
import 'package:student_fit/screens/premium/index.dart';

class PremiumUpgradePage extends StatefulWidget {
  @override
  _PremiumUpgradePageState createState() => _PremiumUpgradePageState();
}

class _PremiumUpgradePageState extends State<PremiumUpgradePage> {
  bool isSelected = false;
  String selectedPlan = '';

  Widget buildPremiumContentBox(
      String plan, String duration, String price, String description) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(36, 0, 255, 0.49),
          width: 2,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedPlan = plan;
                });
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(228, 250, 250, 250),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: selectedPlan == plan
                    ? Center(
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    : Container(),
              ),
            ),
            const SizedBox(width: 16.0),
            Container(
              margin: const EdgeInsets.only(top: 11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        duration,
                        style: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'Inter',
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          height: 1.33523,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'Inter',
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          height: 1.33523,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFFB9B9B9),
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      height: 1.33523,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Upgrade',
        showFavoriteIcon: false,
        onFavoritePressed: () {
          // Handle favorite pressed
        },
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Be Premium',
                style: TextStyle(
                  color: Color(0xFF471AA0),
                  fontFamily: 'Inter',
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  height: 1.69023,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Get unlimited access',
                style: TextStyle(
                  color: Color(0xFF50555C),
                  fontFamily: 'Inter',
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  height: 1.69023,
                ),
              ),
              const SizedBox(height: 44.0),
              buildPremiumContentBox('1_month', '1 month', '\$16.99/m',
                  'Pay once, cancel anytime.'),
              const SizedBox(height: 34.0), // Add spacing between boxes
              buildPremiumContentBox('2_month', '3 months', '\$60.00/m',
                  'Pay once, cancel anytime.'),
              const SizedBox(height: 34.0), // Add spacing between boxes
              buildPremiumContentBox('3_month', '6 months', '\$116.99/m',
                  'Pay once, cancel anytime.'),
              const SizedBox(height: 34.0),
              CustomElevatedButton2(
                buttonText: 'Subscribe',
                onPressed: () {
                  if (selectedPlan.isNotEmpty) {
                    // A plan is selected, proceed with the subscription
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => presPage(),
                      ),
                    );
                  } else {
                    // No plan is selected, show an error message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please select a subscription plan.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
