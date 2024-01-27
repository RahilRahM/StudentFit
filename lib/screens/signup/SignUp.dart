import '../LogIn/index.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/userAuthentication.dart';
import '../welcomePages/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:StudentFit/screens/signup/gender.dart';

class SignUpPage extends StatefulWidget {
  static const PageRoute = '/signup';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _tx_name_controller = TextEditingController();
  final _tx_email_controller = TextEditingController();
  final _tx_pass_controller = TextEditingController();
  final _tx_passconf_controller = TextEditingController();
  String nameError = '';
  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';

  bool showProgressBar = false;
  String errorMessage = '';

  bool isPasswordVisible = false;
  bool validateInputEmail = true;

  Widget buildTextField(
    String hintText,
    IconData icon,
    TextInputType keyboardType,
    ValueChanged<String>? onChanged,
    bool isPassword,
    double width,
    bool validateInput,
    String errorMessage,
    TextEditingController controller,
  ) {
    bool hasError = errorMessage.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                  : validateInput && !isPassword
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
                  onPressed: () {
                    if (isPassword) {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    }
                  },
                ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.1,
            ),
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
                    setState(() {
                      nameError = ''; // Reset error message
                      // Add your validation logic and update nameError if needed
                    });
                  },
                  false,
                  screenWidth * 0.9,
                  true,
                  nameError,
                  _tx_name_controller,
                ),
                buildTextField(
                  'Email ',
                  Icons.email,
                  TextInputType.emailAddress,
                  (value) {
                    bool isValid = EmailValidator.validate(value);
                    setState(() {
                      validateInputEmail = isValid;
                      emailError = isValid ? '' : 'Invalid email format';
                    });
                  },
                  false,
                  screenWidth * 0.9,
                  validateInputEmail,
                  emailError,
                  _tx_email_controller,
                ),
                buildTextField(
                  'Password',
                  Icons.lock,
                  TextInputType.visiblePassword,
                  (value) {
                    setState(() {
                      passwordError = ''; // Reset error message
                      // Add your password validation logic and update passwordError if needed
                    });
                  },
                  true,
                  screenWidth * 0.9,
                  false,
                  passwordError,
                  _tx_pass_controller,
                ),
                buildTextField(
                  'Confirm Password',
                  Icons.lock,
                  TextInputType.visiblePassword,
                  (value) {
                    setState(() {
                      confirmPasswordError = ''; // Reset error message
                      // Add your confirmation logic and update confirmPasswordError if needed
                    });
                  },
                  true,
                  screenWidth * 0.9,
                  false,
                  confirmPasswordError,
                  _tx_passconf_controller,
                ),
                const SizedBox(height: 20),
                // Display error message
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                CustomElevatedButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    actionHandleSignupButton(context);
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInPage(),
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

  void actionHandleSignupButton(BuildContext context) async {
    if (mounted) {
      setState(() {
        showProgressBar = true;
        errorMessage = '';
      });
    }

    // Validate name, email, password, and confirmPassword
    bool isNameValid = _validateName(_tx_name_controller.text);
    bool isEmailValid = _validateEmail(_tx_email_controller.text);
    bool isPasswordValid = _validatePassword(_tx_pass_controller.text);
    bool isConfirmPasswordValid = _validateConfirmPassword(
      _tx_pass_controller.text,
      _tx_passconf_controller.text,
    );

    if (isNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid) {
      var result = await UserAuthentication.signupUser({
        'name': _tx_name_controller.text,
        'email': _tx_email_controller.text,
        'password': _tx_pass_controller.text,
      });

      if (mounted) {
        setState(() {
          showProgressBar = false;
          if (result['status'] == 'success') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GenderPage(userId: result['userId']),
              ),
            );
          } else if (result['message'] == 'email_exists') {
            setState(() {
              emailError = 'Email already exists';
            });
          } else {
            setState(() {
              errorMessage = result['message'];
            });
          }
        });
      }
    } else {
// Passwords or other fields don't match or are invalid
      if (mounted) {
        setState(() {
          showProgressBar = false;
        });
      }
    }
  }

  bool _validateName(String value) {
    if (value.isEmpty) {
      setState(() {
        nameError = 'Name cannot be empty';
      });
      return false;
    }
// Add more validation logic if needed
    return true;
  }

  bool _validateEmail(String value) {
    bool isValid = EmailValidator.validate(value);
    setState(() {
      validateInputEmail = isValid;
      emailError = isValid ? '' : 'Invalid email format';
    });
    return isValid;
  }

  bool _validatePassword(String value) {
// Implement your password validation logic here
    return true; // Change this based on your validation criteria
  }

  bool _validateConfirmPassword(String password, String confirmPassword) {
    bool passwordsMatch = (password == confirmPassword);
    setState(() {
      confirmPasswordError = passwordsMatch ? '' : 'Passwords do not match';
    });
    return passwordsMatch;
  }
}
