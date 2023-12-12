import '../LogIn/index.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../welcomePages/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:student_fit/screens/signup/gender.dart';



class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isPasswordVisible = false;
  bool validateInputEmail = true;
  Widget buildTextField(
    String hintText,
    IconData icon,
    TextInputType keyboardType,
    ValueChanged<String>? onChanged,
    bool isPassword,
    VoidCallback onToggleVisibility,
    double width,
    bool validateInput, // New parameter for validation
  ) {
    return Container(
      width: width,
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          color: isPassword
              ? AppColors.primaryColor
              : validateInput
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.45,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Lobster',
                        fontSize: screenWidth * 0.1,
                        fontWeight: FontWeight.w200,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                buildTextField(
                  'Full name ',
                  Icons.person,
                  TextInputType.text,
                  (value) {
                    // Handle name input
                  },
                  false,
                  () {},
                  screenWidth * 0.9,
                  true, // Set validation to false for full name
                ),
                buildTextField(
                  'Email ',
                  Icons.email,
                  TextInputType.emailAddress,
                  (value) {
                    bool isValid = EmailValidator.validate(value);
                    setState(() {
                      validateInputEmail = isValid;
                    });
                  },
                  false,
                  () {},
                  screenWidth * 0.9,
                  validateInputEmail, //  validateInputEmail variable for email validation
                ),
                buildTextField(
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
                  false, // false validation e for password
                ),
                buildTextField(
                  'Confirm Password',
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
                  false, // false validation for confirm password
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    // Navigate to HomePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenderPage(),
                      ),
                    );
                  },
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(height: 30),
                    const SizedBox(width: 70),
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
