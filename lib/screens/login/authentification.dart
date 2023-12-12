import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:student_fit/screens/login/index.dart';
import 'package:student_fit/screens/welcomePages/widgets/widgets.dart';

class AutoPage extends StatelessWidget {
  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double screenPadding(BuildContext context, double percent) {
    return screenWidth(context) * percent;
  }

  double boxSize(BuildContext context, double size) {
    return screenWidth(context) * size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(screenPadding(context, 0.05)),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset(
                    'assets/images/auto.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenPadding(context, 0.04)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenPadding(context, 0.05)),
                    Container(
                      padding: EdgeInsets.only(
                        left: screenPadding(context, 0.2),
                      ),
                      child: Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 0.07 * screenWidth(context),
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: screenPadding(context, 0.05)),
                    Container(
                      padding: EdgeInsets.only(
                        left: screenPadding(context, 0.1),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Enter the OTP sent to - ',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 0.0375 * screenWidth(context),
                            fontWeight: FontWeight.normal,
                            color: AppColors.blackColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '+213-555555555',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 0.0375 * screenWidth(context),
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenPadding(context, 0.06)),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenPadding(context, 0.0925),
                      ),
                      child: Row(
                        children: [
                          _buildCodeBox(context),
                          _buildCodeBox(context),
                          _buildCodeBox(context),
                          _buildCodeBox(context),
                        ],
                      ),
                    ),
                    SizedBox(height: screenPadding(context, 0.07)),
                    Container(
                      padding: EdgeInsets.only(
                        left: screenPadding(context, 0.35),
                      ),
                      child: Text(
                        '00:12 Sec',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 0.03 * screenWidth(context),
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: screenPadding(context, 0.03)),
                    Container(
                      padding: EdgeInsets.only(
                        left: screenPadding(context, 0.2),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t receive code? ',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 0.0375 * screenWidth(context),
                            fontWeight: FontWeight.normal,
                            color: AppColors.blackColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Re-send',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 0.0375 * screenWidth(context),
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenPadding(context, 0.09)),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenPadding(context, 0.2),
                      ),
                      child: CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordPage(),
                            ),
                          );
                        },
                        buttonText: 'Submit',
                        width: 0.5 * screenWidth(context),
                        height: 0.11 * screenWidth(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeBox(BuildContext context) {
    return Container(
      width: boxSize(context, 0.145),
      height: boxSize(context, 0.145),
      margin: EdgeInsets.only(right: screenPadding(context, 0.045)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 225, 225, 225),
      ),
      child: Center(
        child: Text(
          '', // You can add your code here
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 0.0375 * screenWidth(context),
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
