import 'dart:convert';
import 'otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_otp/email_otp.dart';
import 'package:student_fit/commons/colors.dart';
import 'package:student_fit/constants/endpoints.dart';
import 'package:student_fit/screens/home/home_widgets/app_bar.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();

  Future<bool> isEmailExists(String email) async {
    final response = await http.get(Uri.parse('$apiEndpointIsEmailExists?email=$email'));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['status'] == 200;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Forget Password',
        showFavoriteIcon: false,
        onFavoritePressed: () {
          // Handle favorite pressed
        },
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Image.asset(
                  'assets/images/forgetpwd.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                'Don’t worry! It happens. Please enter your email, and we will send the OTP to this email address.',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              bool emailExists = await isEmailExists(email.text);

                              if (emailExists) {
                                myauth.setConfig(
                                  appEmail: "lilia.ammarkhodja@ensia.edu.dz",
                                  appName: "Email OTP",
                                  userEmail: email.text,
                                  otpLength: 4,
                                  otpType: OTPType.digitsOnly,
                                );

                                if (await myauth.sendOTP()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("OTP has been sent"),
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OtpScreen(
                                        myauth: myauth,
                                        userEmail: email.text,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Oops, OTP send failed"),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Email does not exist"),
                                  ),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.send_rounded,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          hintText: "Email Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
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
