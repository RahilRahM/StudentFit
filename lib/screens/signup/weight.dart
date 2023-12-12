import 'package:flutter/material.dart';
import '../../commons/colors.dart';
import 'style.dart';
import 'height.dart';

class WeightPage extends StatelessWidget {
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
                    'Enter your weight',
                    textAlign: TextAlign.center,
                    style: textBg,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Weight in Kg. You can always change it later.',
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
                child: WeightPicker(),
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
                        MaterialPageRoute(builder: (context) => HeightPage()),
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

class WeightPicker extends StatefulWidget {
  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  // Initial selected weight
  int selectedWeight = 60;

  // Controller for the PageView
  PageController pageController =
      PageController(viewportFraction: 0.2, initialPage: 30);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      int currentIndex = pageController.page?.round() ?? 0;
      setState(() {
        selectedWeight = 30 + currentIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      child: PageView.builder(
        controller: pageController,
        itemCount: 100,
        itemBuilder: (context, index) {
          final weight = 30 + index;
          return _buildWeightItem(weight);
        },
      ),
    );
  }

  Widget _buildWeightItem(int weight) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            weight.toString(),
            style: _getWeightTextStyle(weight),
          ),
          if (weight == selectedWeight)
            Icon(
              Icons.arrow_drop_up,
              size: 55,
              color: AppColors.secondaryColor2,
            ),
        ],
      ),
    );
  }

  TextStyle _getWeightTextStyle(int weight) {
    if (weight == selectedWeight) {
      return TextStyle(
        fontFamily: 'Inter',
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryColor2,
      );
    } else if (weight == selectedWeight + 1 || weight == selectedWeight - 1) {
      return TextStyle(
        fontFamily: 'Inter',
        fontSize: 27,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 0.51),
      );
    } else if (weight == selectedWeight + 2 || weight == selectedWeight - 2) {
      return TextStyle(
        fontFamily: 'Inter',
        fontSize: 23,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 0.3),
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
