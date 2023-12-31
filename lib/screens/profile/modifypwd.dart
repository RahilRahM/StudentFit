import '../home/homepage.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../welcomePages/widgets/widgets.dart';

class ModifyPasswordPage extends StatefulWidget {
  @override
  _ModifyPasswordPageState createState() => _ModifyPasswordPageState();
}

class _ModifyPasswordPageState extends State<ModifyPasswordPage> {
  bool isPasswordVisible = false;
  bool isEmailValid = true;

  Widget buildTextField(String hintText, IconData icon,
      TextInputType keyboardType, ValueChanged<String>? onChanged) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // Adjust width as needed
      height: 65,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          color: AppColors.primaryColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              keyboardType: keyboardType,
              onChanged: onChanged,
            ),
          ),
          IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              // Toggle password visibility
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Back Button
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(
                      context); // Navigate back to the previous screen
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
              ),
            ),

            const Positioned(
              top: 150,
              left: 14,
              child: SizedBox(
                width: 268,
                height: 44,
                child: Center(
                  child: Text(
                    'Modify Password',
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                      letterSpacing: 0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),

            // New Password Box
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.3, // Adjust top position as needed
              left: MediaQuery.of(context).size.width *
                  0.05, // Adjust left position as needed
              child: buildTextField(
                'New Password',
                Icons.lock,
                TextInputType.visiblePassword,
                (value) {
                  // Handle new password input
                },
              ),
            ),

            // Confirm Password Box
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.443, // Adjust top position as needed
              right: MediaQuery.of(context).size.width *
                  0.05, // Adjust right position as needed
              child: buildTextField(
                'Confirm Password',
                Icons.lock,
                TextInputType.visiblePassword,
                (value) {
                  // Handle confirm password input
                },
              ),
            ),

            // Confirm Button
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.6, // Adjust top position as needed
              left: MediaQuery.of(context).size.width *
                  0.1, // Adjust left position as needed
              child: CustomElevatedButton(
                buttonText: 'Confirm',
                onPressed: () {
                  // Navigate to HomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(appBarTitle: 'Home'),
                    ),
                  );
                },
                width: MediaQuery.of(context).size.width *
                    0.8, // Adjust width as needed
                height: 61,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
