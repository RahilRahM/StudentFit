import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  Widget buildTextField(String hintText, IconData icon, TextInputType keyboardType, ValueChanged<String>? onChanged, bool isEmailValid) {
    return Container(
      width: 360,
      height: 65,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          color: isEmailValid ? Colors.black : Colors.red,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.black,
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(50),
              child: Image.asset(
                'assets/images/forgetpwd.png', // Replace with your image path
                width: 400,
                height: 320,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Don’t worry! It happens. Please enter the phone number we will send the OTP to this phone number.',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Phone number input field
                  buildTextField(
                    'Enter the phone number',
                    Icons.phone,
                    TextInputType.phone,
                    (value) {
                      // Handle phone number input
                    },
                    true, // You can set isEmailValid to true or false based on your logic
                  ),
                  const SizedBox(height: 16),
                  
                  const SizedBox(height: 16),
                  // Button to navigate to Verification page
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to "Verification" page with animation
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => VerificationPage(),
                          transitionsBuilder: (context, animation, _, child) {
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
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF471AA0),
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

class VerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your Verification page content goes here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: const Center(
        child: Text('Verification Page'),
      ),
    );
  }
}
