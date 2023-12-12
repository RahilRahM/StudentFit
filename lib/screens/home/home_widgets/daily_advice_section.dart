import 'dart:math';
import 'dart:async';
import '../../../commons/colors.dart';
import 'package:flutter/material.dart';

class DailyAdviceSection extends StatefulWidget {
  @override
  _DailyAdviceSectionState createState() => _DailyAdviceSectionState();
}

class _DailyAdviceSectionState extends State<DailyAdviceSection> {
  // List of predefined advice
  List<String> adviceList = [
    'Take breaks to stretch and relax throughout the day.',
    'Stay hydrated by drinking enough water.',
    'Get enough sleep for a healthy mind and body.',
    'Set realistic goals and celebrate small victories.',
    'Practice mindfulness and deep breathing exercises.',
    'Eat a balanced diet with a variety of fruits and vegetables.',
    'Prioritize self-care and make time for activities you enjoy.',
    'Exercise regularly to boost your physical and mental well-being.',
    'Surround yourself with positive and supportive people.',
    'Learn to manage stress through meditation or yoga.',
    'Focus on what you can control and let go of what you can\'t.',
    'Practice gratitude by reflecting on the positive aspects of your day.',
    'Take time to connect with friends and family.',
    'Continuously seek opportunities for personal and professional growth.',
    'Embrace a positive mindset and challenge negative thoughts.',
    'Learn from your mistakes and use them as opportunities to grow.',
    'Limit screen time and take breaks from technology.',
    'Volunteer or engage in acts of kindness to contribute to your community.',
    'Plan and organize your tasks to reduce feelings of overwhelm.',
    'Remember that it\'s okay to ask for help when you need it.',
  ];

  // Variable to store the selected advice
  late String selectedAdvice;

  @override
  void initState() {
    super.initState();
    // Select the first advice when the widget is initialized
    selectedAdvice = adviceList.first;

    // Start a timer to update advice every 20 seconds
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      updateAdvice();
    });
  }

  // Method to update the displayed advice
  void updateAdvice() {
    setState(() {
      final random = Random();
      selectedAdvice = adviceList[random.nextInt(adviceList.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // Fixed width of the advice box
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                AppColors.secondaryColor, // You can change the color as needed
            width: 0.01, // You can change the width as needed
          ),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 221, 221, 255).withOpacity(0.7),
              const Color.fromARGB(255, 255, 253, 253).withOpacity(0.8),
            ],
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColorHome.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons
                      .lightbulb_outline, // Replace with the icon you want to use
                  color: Color.fromARGB(255, 252, 255, 82),
                ),
                Text(
                  'Advice of the Day',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons
                      .lightbulb_outline, // Replace with the icon you want to use
                  color: Color.fromARGB(255, 252, 255, 82),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedAdvice,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16.0,
                    fontFamily: 'Arial',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
