import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../premium/subscription.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:StudentFit/commons/colors.dart';
import '../../screens/home/home_widgets/app_bar.dart';
import '../../screens/home/home_widgets/side_bar.dart';
import 'package:StudentFit/screens/profile/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  bool isClicked = false;
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      setState(() {
        userName = userData['user_name'];
        userEmail = userData['user_email'];
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Save the selected image to cache
      final appDirectory = await getTemporaryDirectory();
      final cacheImagePath = '${appDirectory.path}/profile_image.jpg';
      await _image!.copy(cacheImagePath);

      // Save the image path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pic', cacheImagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Profile',
        actions: [],
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: _image != null
                    ? ClipOval(
                        child: Image.file(
                          _image!,
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    : InkWell(
                        onTap: _pickImage,
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 40.0,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 16.0),
              Text(
                userName ?? 'Default Name',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                userEmail ?? 'example@example.com',
                style: TextStyle(
                  color: Color(0xFF71839B),
                  fontFamily: 'Inter',
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 40),
              buildDrawerItem(
                context,
                'Edit Profile',
                Icons.person,
                const Color(0xFF471AA0),
                20.0,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        image: _image,
                        onImageChanged: (newImage) {
                          setState(() {
                            _image = newImage;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 45),
              buildDrawerItem(
                context,
                'Notifications',
                Icons.notifications,
                const Color(0xFF471AA0),
                20.0,
                () {
                  // Navigate to EditProfilePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsPage()),
                  );
                },
              ),
              const SizedBox(height: 45),
              buildDrawerItem(
                context,
                'Help',
                Icons.help,
                const Color(0xFF471AA0),
                20.0,
                () {},
              ),
              const SizedBox(height: 45),
              buildDrawerItem(
                context,
                'Password',
                Icons.lock,
                const Color(0xFF471AA0),
                20.0,
                () {
                  // Navigate to EditProfilePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ModifyPasswordPage()),
                  );
                },
              ),
              const SizedBox(height: 55),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PremiumUpgradePage()),
                  );
                },
                onTapDown: (_) {
                  setState(() {
                    isClicked = true;
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    isClicked = false;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isClicked = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 82,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19.246),
                    border: Border.all(
                      color: isClicked
                          ? Colors.transparent
                          : const Color.fromARGB(255, 108, 89, 146),
                      width: 2.0,
                    ),
                    color: isClicked
                        ? const Color.fromARGB(255, 220, 210, 229)
                        : const Color.fromARGB(255, 241, 230, 249),
                    boxShadow: [
                      BoxShadow(
                        color: isClicked
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.5),
                        spreadRadius: isClicked ? 0 : 2,
                        blurRadius: isClicked ? 0 : 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    gradient: isClicked
                        ? null
                        : const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 241, 230, 249),
                              Colors.white,
                            ],
                          ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upgrade to StudentFit+',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 18.329,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Unlock exclusive features',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Jomolhari',
                                fontSize: 13.747,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
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

Widget buildDrawerItem(BuildContext context, String title, IconData icon,
    Color color, double fontSize, VoidCallback onTap) {
  return Column(
    children: [
      ListTile(
        onTap: onTap,
        title: buildDrawerItemText(title, icon, color, fontSize),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 60.0),
        child: Divider(
          color: AppColors.greyColorHome,
          height: 1,
        ),
      ),
    ],
  );
}

buildDrawerItemText(String text, IconData icon, Color color, double fontSize) {
  return Row(
    children: [
      Icon(
        icon,
        color: AppColors.primaryColor,
        size: 24.0,
      ),
      const SizedBox(width: 35.0),
      Text(
        text,
        style: TextStyle(
          color: AppColors.blackColor,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );
}
