import 'dart:io';
import 'package:flutter/material.dart';
import 'package:StudentFit/commons/colors.dart';
import '../../screens/home/home_widgets/app_bar.dart';
import '../../screens/home/home_widgets/side_bar.dart';
import 'package:StudentFit/screens/profile/index.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  File? _image;

  Map<String, bool> switchStates = {
    'Change notifications': false,
    'Sound': false,
    'Vibrate': false,
    'App updates': false,
    'New service available': false,
    'New tips available': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Notifications',
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
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              buildDrawerItem2(
                context,
                'Change notifications',
                switchStates['Change notifications'] ?? false,
                AppColors.primaryColor,
                20.0,
                () {
                  // Handle switch toggle
                  setState(() {
                    switchStates['Change notifications'] =
                        !(switchStates['Change notifications'] ?? false);
                  });
                },
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(image: _image),
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),
              buildDrawerItem2(
                context,
                'Sound',
                switchStates['Sound'] ?? false,
                AppColors.primaryColor,
                20.0,
                () {
                  // Handle switch toggle
                  setState(() {
                    switchStates['Sound'] = !(switchStates['Sound'] ?? false);
                  });
                },
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(image: _image),
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),
              buildDrawerItem2(
                context,
                'Vibrate',
                switchStates['Vibrate'] ?? false,
                AppColors.primaryColor,
                20.0,
                () {
                  // Handle switch toggle
                  setState(() {
                    switchStates['Vibrate'] =
                        !(switchStates['Vibrate'] ?? false);
                  });
                },
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(image: _image),
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),
              buildDrawerItem2(
                context,
                'App updates',
                switchStates['App updates'] ?? false,
                AppColors.primaryColor,
                20.0,
                () {
                  // Handle switch toggle
                  setState(() {
                    switchStates['App updates'] =
                        !(switchStates['App updates'] ?? false);
                  });
                },
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(image: _image),
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),
              buildDrawerItem2(
                context,
                'New service available',
                switchStates['New service available'] ?? false,
                AppColors.primaryColor,
                20.0,
                () {
                  // Handle switch toggle
                  setState(() {
                    switchStates['New service available'] =
                        !(switchStates['New service available'] ?? false);
                  });
                },
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(image: _image),
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),
              buildDrawerItem2(
                context,
                'New tips available',
                switchStates['New tips available'] ?? false,
                AppColors.primaryColor,
                20.0,
                () {
                  // Handle switch toggle
                  setState(() {
                    switchStates['New tips available'] =
                        !(switchStates['New tips available'] ?? false);
                  });
                },
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(image: _image),
                    ),
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

Widget buildDrawerItem2(
    BuildContext context,
    String title,
    bool switchValue,
    Color color,
    double fontSize,
    VoidCallback onSwitchChanged,
    VoidCallback onTap) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          Switch(
            value: switchValue,
            onChanged: (value) => onSwitchChanged(),
            activeColor: color,
          ),
        ],
      ),
      const Divider(
        color: AppColors.greyColorHome,
        height: 1.0,
      ),
    ],
  );
}
