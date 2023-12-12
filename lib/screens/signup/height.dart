import 'style.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:student_fit/screens/home/homepage.dart';


class HeightPage extends StatelessWidget {
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
                    'Enter your height',
                    textAlign: TextAlign.center,
                    style: textBg,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Height in cm. You can always change it later.',
                    textAlign: TextAlign.center,
                    style: textSm,
                  )
                ],
              ),
            ),

            // Body Section
            SizedBox(
              height: screenHeight * 0.5,
              child: Center(
                child: HeightPicker(),
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
                        MaterialPageRoute(
                          builder: (context) => const HomePage(appBarTitle: 'Home',),
                        ),
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

class HeightPicker extends StatefulWidget {
  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  // Initial selected height
  int selectedHeight = 150;

  // Controller for the ListWheelScrollView
  FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: 50);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListWheelScrollView(
        controller: scrollController,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedHeight = 100 + index;
          });
        },
        itemExtent: 50,
        children: List.generate(130, (index) {
          final height = 100 + index;
          return _buildHeightItem(height);
        }),
      ),
    );
  }

  Widget _buildHeightItem(int height) {
    return Container(
      child: Center(
        child: Column(
          children: [
            // Line above the text
            Container(
              height: 2,
              width: 40,
              color: (height == selectedHeight)
                  ? AppColors.secondaryColor2
                  : Colors.transparent,
            ),
            // Text
            Center(
              child: Text(
                height.toString(),
                style: _getHeightTextStyle(height),
              ),
            ),
            // Line below the text
            Container(
              height: 2,
              width: 40,
              color: (height == selectedHeight)
                  ? AppColors.secondaryColor2
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getHeightTextStyle(int height) {
    if (height == selectedHeight) {
      return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 23,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryColor2,
      );
    } else if (height == selectedHeight + 1 || height == selectedHeight - 1) {
      return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      );
    } else if (height == selectedHeight + 2 || height == selectedHeight - 2) {
      return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 0.51),
      );
    } else {
      return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 0.3),
      );
    }
  }
}
