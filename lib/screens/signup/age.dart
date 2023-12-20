import 'style.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/userAuthentication.dart';
import 'package:student_fit/screens/signup/height.dart';

class AgePage extends StatefulWidget {
  final int userId;

  AgePage({required this.userId});

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int age = 18;

  void updateAge(int newAge) {
    setState(() {
      age = newAge;
    });
  }

  void actionHandleAgeUpdate(BuildContext context) async {
    String result = await UserAuthentication.insertAge(widget.userId, age);

    if (result == 'success') {
      print('Age added successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HeightPage(userId: widget.userId)),
      );
    } else {
      // Handle error updating age
      print('Error updating age: $result');
    }
  }

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
                child: AgePicker(updateAge: updateAge),
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
                      actionHandleAgeUpdate(context);
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
  final Function updateAge;

  AgePicker({required this.updateAge});

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
          widget.updateAge(selectedAge);
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
    return Container(
      child: Center(
        child: Column(children: [
          // Line above the text
          Container(
            height: 2,
            width: 40,
            color: (age == selectedAge)
                ? AppColors.secondaryColor2
                : Colors.transparent,
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
            color: (age == selectedAge)
                ? AppColors.secondaryColor2
                : Colors.transparent,
          ),
        ]),
      ),
    );
  }

  TextStyle _getAgeTextStyle(int age) {
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
