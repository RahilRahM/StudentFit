import 'authentification.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../welcomePages/widgets/widgets.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool isPhoneNumberValid = true;

  Widget buildTextField(String hintText, IconData icon,
      TextInputType keyboardType, ValueChanged<String>? onChanged) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 100, top: 10, bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: AppColors.primaryColor,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.redColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.redColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: (value) {
          if (value != null && !isValidPhoneNumber(value)) {
            return 'Invalid phone number';
          }
          return null;
        },
      ),
    );
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.isEmpty ||
        (phoneNumber.isNotEmpty && phoneNumber.contains(RegExp(r'^[0-9]+$')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Don’t worry! It happens. Please enter the phone number, and we will send the OTP to this phone number.',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/forgetpwd.png',
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 20),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextField(
                        'Enter the phone number',
                        Icons.phone,
                        TextInputType.phone,
                        (value) {
                          setState(() {
                            isPhoneNumberValid = isValidPhoneNumber(value);
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  AutoPage(),
                              transitionsBuilder:
                                  (context, animation, _, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeOut;
                                var tween = Tween(begin: begin, end: end).chain(
                                  CurveTween(curve: curve),
                                );
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                            ),
                          );
                        },
                        buttonText: 'Continue',
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 55,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
