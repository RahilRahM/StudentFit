import 'forgetPassword.dart';
import '../signup/SignUp.dart';
import '../home/homepage.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/userAuthentication.dart';
import '../welcomePages/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';

class LogInPage extends StatefulWidget {
  static const PageRoute = '/login';

  const LogInPage({Key? key});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _tx_email_controller = TextEditingController();
  final _tx_pass_controller = TextEditingController();

  bool isPasswordVisible = false;
  bool show_progress_bar = false;
  String emailErrorMessage = '';
  String passwordErrorMessage = '';
  String error_message = '';
  
  
  // Common styling for text fields
  Widget buildTextField(
    String hintText,
    IconData icon,
    TextInputType keyboardType,
    ValueChanged<String>? onChanged,
    bool isPassword,
    VoidCallback onToggleVisibility,
    double width,
    TextEditingController controller,
    String errorMessage,
  ) {
    const double boxMargin = 15.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: 65,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: boxMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              color:
                  errorMessage.isNotEmpty ? Colors.red : AppColors.primaryColor,
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
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: onToggleVisibility,
                ),
            ],
          ),
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
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
            Positioned(
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
                    emailErrorMessage = isValid ? '' : 'Invalid email address';
                  });
                },
                false,
                () {},
                screenWidth * 0.9,
                _tx_email_controller,
                emailErrorMessage,
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
                  // Note: You can add password validation logic here if needed
                },
                true,
                () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                screenWidth * 0.9,
                _tx_pass_controller,
                passwordErrorMessage,
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
                  action_handle_login_button();
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
                          builder: (context) => SignUpPage(),
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

  void action_handle_login_button() async {
    setState(() {
      show_progress_bar = true;
      error_message = '';
      passwordErrorMessage = '';
      emailErrorMessage = '';
    });

    if (_tx_email_controller.text.isEmpty) {
      setState(() {
        emailErrorMessage = 'Email cannot be empty';
      });
    }
    if (_tx_pass_controller.text.isEmpty) {
      setState(() {
        passwordErrorMessage = 'Password cannot be empty';
      });
    } else {
      String result = await UserAuthentication.loginUser(
        _tx_email_controller.text,
        _tx_pass_controller.text,
      );

      setState(() {
        show_progress_bar = false;
        if (result == 'success') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(appBarTitle: 'Home'),
            ),
          );
        } else {
          showErrorMessage(result);
        }
      });
    }
  }

  void showErrorMessage(String message) {
    if (message.toLowerCase().contains('password')) {
      setState(() {
        passwordErrorMessage = message;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
