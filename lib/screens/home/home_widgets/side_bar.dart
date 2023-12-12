import '../../../commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:student_fit/commons/index.dart';
import 'package:student_fit/screens/login/login.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
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
        buildDrawerItem(
            context, 'Recipes', Icons.restaurant, AppColors.primaryColor, 20.0),
        const SizedBox(height: 30),
        buildDrawerItem(context, 'Calendar', Icons.calendar_month,
            AppColors.primaryColor, 20.0),
        const SizedBox(height: 30),
        buildDrawerItem(
            context, 'Schedule', Icons.schedule, AppColors.primaryColor, 20.0),
        const SizedBox(height: 30),
        buildDrawerItem(context, 'Analytics', Icons.analytics,
            AppColors.primaryColor, 20.0),
        const SizedBox(height: 30),
        buildDrawerItem(
            context, 'Logout', Icons.logout, AppColors.primaryColor, 20.0),
        const SizedBox(height: 60),
        GestureDetector(
          onTap: () {
            // Navigate to the user profile page or any other desired page
            Navigator.pushNamed(context, '/profile');
          },
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
            title: const Text(
              'Lilia Amk',
              style: TextStyle(
                color: Color(0xFF324054),
                fontFamily: 'Inter',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              'liliaamk@example.com',
              style: TextStyle(
                color: Color(0xFF324054),
                fontFamily: 'Inter',
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

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
            onPressed: () {
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
