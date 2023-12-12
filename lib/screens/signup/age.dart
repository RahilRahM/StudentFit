import 'package:flutter/material.dart';
import '../../commons/colors.dart';
import 'style.dart';
import 'weight.dart';

class AgePage extends StatelessWidget {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter your age',
                    textAlign: TextAlign.center,
                    style: textBg,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'This will help you to provide a personalized plan',
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
                child: AgePicker(),
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
                    style: button_next,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeightPage()),
                      );
                    },
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

class AgePicker extends StatefulWidget {
  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  // Initial selected age
  int selectedAge = 18;

  // Controller for the ListWheelScrollView
  FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: 5);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListWheelScrollView(
        controller: scrollController,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedAge = 13 + index;
          });
        },
        itemExtent: 50,
        children: List.generate(53, (index) {
          final age = 13 + index;
          return _buildAgeItem(age);
        }),
      ),
    );
  }

  Widget _buildAgeItem(int age) {
    // Build your age item widget here
    // You can customize the appearance based on the selected age
    return Container(
      child: Center(
        child: Column(children: [
          // Line above the text
          Container(
            height: 2,
            width: 40,
            color: (age == selectedAge) ? AppColors.secondaryColor2 : Colors.transparent,
          ),
          // Text
          Center(
            child: Text(
              age.toString(),
              style: _getAgeTextStyle(age),
            ),
          ),
          // Line below the text
          Container(
            height: 2,
            width: 40,
            color: (age == selectedAge) ? AppColors.secondaryColor2 : Colors.transparent,
          ),
        ]),
      ),
    );
  }

  TextStyle _getAgeTextStyle(int age) {
    // Customize the text style based on the selected age
    // This is just an example, you can adjust it as needed
    if (age == selectedAge) {
      return TextStyle(
        fontFamily: 'Inter',
        fontSize: 23,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryColor2,
      );
    } else if (age == selectedAge + 1 || age == selectedAge - 1) {
      return TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      );
    } else if (age == selectedAge + 2 || age == selectedAge - 2) {
      return TextStyle(
        fontFamily: 'Inter',
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 0.51),
      );
    } else {
      return TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 0.3),
      );
    }
  }
}
