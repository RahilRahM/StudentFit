import 'dart:convert';
import '../../../commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:StudentFit/commons/index.dart';
import 'package:StudentFit/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Handle loading state
          return CircularProgressIndicator(); // or any other loading indicator
        } else if (snapshot.hasError) {
          // Handle error
          return Text('Error: ${snapshot.error}');
        } else {
          // SharedPreferences has been loaded successfully
          final sharedPreferences = snapshot.data;
          final userDataString = sharedPreferences?.getString('user');

          Map<String, dynamic>? userData;

          if (userDataString != null) {
            userData = jsonDecode(userDataString);
          }

          final name = userData?['user_name'] ?? 'Default Name';
          final email = userData?['user_email'] ?? 'example@example.com';

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 80),
              ListTile(
                title: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Center(
                    child: Text(
                      'StudentFit',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'Lobster',
                        fontSize: 54.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              buildDrawerItem(
                  context, 'Home', Icons.home, AppColors.primaryColor, 20.0),
              const SizedBox(height: 30),
              buildDrawerItem(context, 'Recipes', Icons.restaurant,
                  AppColors.primaryColor, 20.0),
              const SizedBox(height: 30),
              buildDrawerItem(context, 'Calendar', Icons.calendar_month,
                  AppColors.primaryColor, 20.0),
              const SizedBox(height: 30),
              buildDrawerItem(context, 'Schedule', Icons.schedule,
                  AppColors.primaryColor, 20.0),
              const SizedBox(height: 30),
              buildDrawerItem(context, 'Analytics', Icons.analytics,
                  AppColors.primaryColor, 20.0),
              const SizedBox(height: 30),
              buildDrawerItem(context, 'Logout', Icons.logout,
                  AppColors.primaryColor, 20.0),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  // Navigate to the user profile page or any other desired page
                  Navigator.pushNamed(context, '/profile');
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  tileColor: Colors.grey[200],
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    name, // Use the retrieved name
                    style: TextStyle(
                      color: Color(0xFF324054),
                      fontFamily: 'Inter',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    email, // Use the retrieved email
                    style: TextStyle(
                      color: Color(0xFF324054),
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    ),
  );
}

// Fill in similar comments for the following function
ListTile buildDrawerItem(BuildContext context, String text, IconData icon,
    Color textColor, double fontSize) {
  return ListTile(
    title: Text(
      text,
      style: TextStyle(
        color: AppColors.blackColor,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      ),
    ),
    leading: Icon(
      icon,
      color: textColor,
      size: fontSize,
    ),
    onTap: () {
      // Handle item click
      Navigator.pop(context);
      // Show confirmation dialog for Logout
      if (text == 'Logout') {
        _showLogoutConfirmationDialog(context);
      } else {
        // Navigate to the corresponding page, e.g., Homepage
        if (text == 'Home') {
          Navigator.pushNamed(context, '/homepage');
        }
        if (text == 'Recipes') {
          Navigator.pushNamed(context, '/recipepage');
        }
        if (text == 'Calendar') {
          Navigator.pushNamed(context, '/calendar');
        }
        if (text == 'Schedule') {
          Navigator.pushNamed(context, '/schedule');
        }
        if (text == 'Analytics') {
          Navigator.pushNamed(context, '/analytics');
        }
      }
    },
  );
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Logout'),
            onPressed: () async {
              await _clearSharedPreferences();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInPage(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

Future<void> _clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // This clears all data stored in SharedPreferences
}
