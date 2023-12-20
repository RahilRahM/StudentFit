import 'dart:convert';
import '../../commons/colors.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_fit/screens/home/homepage.dart';
import 'package:student_fit/screens/home/home_widgets/app_bar.dart';
import 'package:student_fit/screens/welcomePages/widgets/widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  final String userEmail;

  const ChangePasswordPage({Key? key, required this.userEmail})
      : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String newPasswordError = '';
  String confirmPasswordError = '';
  String oldPassword = '';

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: '',
        showFavoriteIcon: false,
        onFavoritePressed: () {},
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.w200,
                          height: 1.25,
                          letterSpacing: 0,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextField(
                        'New Password',
                        Icons.lock,
                        TextInputType.visiblePassword,
                        (value) {
                          setState(() {
                            newPasswordError = '';
                          });
                        },
                        true,
                        screenWidth,
                        newPasswordController,
                        newPasswordError,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        'Confirm New Password',
                        Icons.lock,
                        TextInputType.visiblePassword,
                        (value) {
                          setState(() {
                            confirmPasswordError = '';
                          });
                        },
                        true,
                        screenWidth,
                        confirmPasswordController,
                        confirmPasswordError,
                      ),
                      const SizedBox(height: 30),
                      CustomElevatedButton(
                        onPressed: () {
                          actionHandleChangePasswordButton(context);
                        },
                        buttonText: 'Confirm',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.08,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(
    String hintText,
    IconData icon,
    TextInputType keyboardType,
    ValueChanged<String>? onChanged,
    bool isPassword,
    double width,
    TextEditingController controller,
    String errorMessage,
  ) {
    bool hasError = errorMessage.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: 65,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              color: hasError ? Colors.red : AppColors.primaryColor,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: width * 0.07,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
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
                    isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: width * 0.03,
              ),
            ),
          ),
      ],
    );
  }

  Future<bool> updatePasswordInDatabase(
      String email, String newPassword) async {
    const apiUrl =
        'https://vercel-test-snowy-chi.vercel.app/users.changePassword';
    final response = await http.put(
      Uri.parse(apiUrl),
      body: {
        'email': email,
        'newPassword': newPassword,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void actionHandleChangePasswordButton(BuildContext context) async {
    bool isNewPasswordValid = _validatePassword(newPasswordController.text);
    bool isConfirmNewPasswordValid = _validateConfirmPassword(
      newPasswordController.text,
      confirmPasswordController.text,
    );
  
    if (isNewPasswordValid && isConfirmNewPasswordValid) {
      // Check if the new password is the same as the old one
      if (_isNewPasswordSameAsOld(newPasswordController.text)) {
        setState(() {
          newPasswordError = 'New password must be different from the old one';
        });
        return;
      }
  
      String hashedPassword =
          hashPassword(newPasswordController.text, 'unique_salt_for_each_user');
  
      bool passwordUpdateSuccess =
          await updatePasswordInDatabase(widget.userEmail, hashedPassword);
  
      if (passwordUpdateSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(appBarTitle: 'Home'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password update failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  

  static String hashPassword(String password, String salt) {
    var bytes = utf8.encode(password + salt);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        newPasswordError = 'Password cannot be empty';
      });
      return false;
    } else if (_isNewPasswordSameAsOld(value)) {
      setState(() {
        newPasswordError = 'New password must be different from the old one';
      });
      return false;
    }
    return true;
  }
  
  bool _isNewPasswordSameAsOld(String newPassword) {

    String hashedNewPassword = hashPassword(newPassword, 'unique_salt_for_each_user');
  

    String hashedOldPassword = fetchHashedOldPassword(); 
  

    print('newPassword: $newPassword');
    print('hashedNewPassword: $hashedNewPassword');
    print('hashedOldPassword: $hashedOldPassword');

    if (hashedNewPassword == hashedOldPassword) {
      print('Passwords are the same.');
      return true;
    } else {
      print('Passwords are different.');
      return false;
    }
  }
  
  String fetchHashedOldPassword() {

    return hashPassword(oldPassword, 'unique_salt_for_each_user');
  }
  

  bool _validateConfirmPassword(String password, String confirmPassword) {
    bool passwordsMatch = (password == confirmPassword);
    setState(() {
      confirmPasswordError = passwordsMatch ? '' : 'Passwords do not match';
    });
    return passwordsMatch;
  }
}
