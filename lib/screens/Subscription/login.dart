import 'forgetPassword.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isPasswordVisible = false;
  bool isEmailValid = true;

  // Method for common styling of text fields
  Widget buildTextField(String hintText, IconData icon, TextInputType keyboardType, ValueChanged<String>? onChanged) {
    return Container(
      width: 360,
      height: 65,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          color: isEmailValid ? AppColors.primaryColor : Colors.red,
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
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              keyboardType: keyboardType,
              onChanged: onChanged,
            ),
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
            // Primary circle in the top right corner
            Positioned(
              top: -30,
              right: -10,
              child: Container(
                width: 105,
                height: 105,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.primaryColor],
                  ),
                ),
              ),
            ),
            // Secondary circle below the primary circle
            Positioned(
              top: 20,
              left: 380,
              child: Container(
                width: 95,
                height: 95,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.secondaryColor,
                      AppColors.secondaryColor
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: 0,
              child: Container(
                width: 95,
                height: 95,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.secondaryColor,
                      AppColors.secondaryColor
                    ],
                  ),
                ),
              ),
            ),
            // Secondary circle above the primary circle
            Positioned(
              bottom: -10,
              left: -45,
              child: Container(
                width: 105,
                height: 105,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.primaryColor],
                  ),
                ),
              ),
            ),
            // Log In text in the center-left
            const Positioned(
              top: 165,
              left: 8,
              child: SizedBox(
                width: 150,
                height: 60,
                child: Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 45,
                      fontWeight: FontWeight.w200,
                      height: 1.25,
                      letterSpacing: 0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),

             // Email or User Name Box
      Positioned(
        top: 270,
        left: 30,
        child: buildTextField(
          'Email or User Name',
          Icons.person,
          TextInputType.emailAddress,
          (value) {
            bool isValid = EmailValidator.validate(value);
            setState(() {
              isEmailValid = isValid;
            });
          },
        ),
      ),

            // Password Box
            Positioned(
              top: 370,
              left: 30,
              child: Container(
                width: 360,
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
                    // Password Icon
                    const Icon(
                      Icons.lock,
                      size: 30,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    // Password Text Field
                    Expanded(
                      child: TextField(
                        obscureText: !isPasswordVisible,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // Eye Icon
                    IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
              ),
            ),

            // Forget Password Text
            Positioned(
              top: 460,
              left: 240,
              child: GestureDetector(
                onTap: () {
                  // Navigate to ForgetPassword page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
                  );
                },
                child: const Text(
                  'Forget Password?',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    letterSpacing: 0,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            // Log In Button
            Positioned(
              top: 490,
              left: 55,
              child: GestureDetector(
                onTap: () {
                  // Navigate to ForgetPassword page
                },
                child: Container(
                  width: 300,
                  height: 61,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Don't have account Text
            const Positioned(
              top: 585,
              left: 90,
              child: Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: 0,
                  color: AppColors.primaryColor,
                ),
              ),
            ),

            // Sign Up Text
            const Positioned(
              top: 585,
              left: 263,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: 0,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
