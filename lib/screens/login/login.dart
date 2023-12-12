import 'forgetPassword.dart';
import '../signup/SignUp.dart';
import '../home/homepage.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../welcomePages/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isPasswordVisible = false;
  bool isEmailValid = true;

  // Common styling for text fields
  Widget buildTextField(
    String hintText,
    IconData icon,
    TextInputType keyboardType,
    ValueChanged<String>? onChanged,
    bool isPassword,
    VoidCallback onToggleVisibility,
    double width,
  ) {
    const double boxMargin = 15.0;
    return Container(
      width: width,
      height: 65,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: boxMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          color: isPassword
              ? AppColors.primaryColor
              : isEmailValid
                  ? AppColors.primaryColor
                  : Colors.red,
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
              obscureText: isPassword && !isPasswordVisible,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              keyboardType: keyboardType,
              onChanged: onChanged,
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.primaryColor,
              ),
              onPressed: onToggleVisibility,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            /*Back Button
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
            ),*/
            const Positioned(
              top: 120,
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
            Positioned(
              top: screenHeight * 0.26,
              left: screenWidth * 0.05,
              child: buildTextField(
                'Email',
                Icons.person,
                TextInputType.emailAddress,
                (value) {
                  bool isValid = EmailValidator.validate(value);
                  setState(() {
                    isEmailValid = isValid;
                  });
                },
                false,
                () {},
                screenWidth * 0.9,
              ),
            ),
            Positioned(
              top: screenHeight * 0.37,
              left: screenWidth * 0.05,
              child: buildTextField(
                'Password',
                Icons.lock,
                TextInputType.visiblePassword,
                (value) {
                  // Handle password input
                },
                true,
                () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                screenWidth * 0.9,
              ),
            ),
            Positioned(
              top: screenHeight * 0.47,
              left: screenWidth * 0.63,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPasswordPage(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20.0, top: 18),
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                      letterSpacing: 0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.55,
              left: screenWidth * 0.05,
              child: CustomElevatedButton(
                buttonText: 'Log In',
                onPressed: () {
                  // Navigate to HomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(appBarTitle: 'Home'),
                    ),
                  );
                },
                width: screenWidth * 0.9,
                height: screenHeight * 0.08,
              ),
            ),
            Positioned(
              top: screenHeight * 0.68,
              left: screenWidth * 0.22,
              child: Row(
                children: [
                  const Text(
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
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SignUpPage(), // Replace with your SignUpPage
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        letterSpacing: 0,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
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
}
