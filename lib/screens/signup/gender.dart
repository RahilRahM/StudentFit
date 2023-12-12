import 'age.dart';
import 'style.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  bool get isGenderSelected => isMaleSelected || isFemaleSelected;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text Section
            Container(
              width: screenWidth * 0.9,
              alignment: Alignment.center,
              height: screenHeight * 0.25,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tell us about yourself',
                    textAlign: TextAlign.center,
                    style: textBg,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'To give you a better experience, we need to know you',
                    textAlign: TextAlign.center,
                    style: textSm,
                  )
                ],
              ),
            ),

            // Body Section
            Container(
              height: screenHeight * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Circle buttons
                    CircleButton(
                      icon: Icons.male,
                      text: 'Male', // Add this line
                      isSelected: isMaleSelected,
                      onPressed: () {
                        setState(() {
                          isMaleSelected = true;
                          isFemaleSelected = false;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    CircleButton(
                      icon: Icons.female,
                      text: 'Female', // Add this line
                      isSelected: isFemaleSelected,
                      onPressed: () {
                        setState(() {
                          isMaleSelected = false;
                          isFemaleSelected = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Buttons Section
            Container(
              alignment: Alignment.center,
              height: screenHeight * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: button_back,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                  ),
                  ElevatedButton(
                    style: isGenderSelected
                        ? button_next
                        : button_next.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(AppColors.grey1),
                          ),
                    onPressed: isGenderSelected
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AgePage()),
                            );
                          }
                        : null, // Disable button if no gender is selected
                    child: Text('Continue'),
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

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  CircleButton({
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 123,
        height: 123,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? AppColors.secondaryColor2
              : AppColors.grey1, // Use your original color values
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 58,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
