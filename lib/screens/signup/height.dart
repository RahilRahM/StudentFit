import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/userAuthentication.dart';
import 'package:StudentFit/screens/signup/index.dart';

class HeightPage extends StatefulWidget {
  final int userId;

  HeightPage({required this.userId});

  @override
  _HeightPageState createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int height = 170;

  void updateHeight(int newHeight) {
    setState(() {
      height = newHeight;
    });
  }

  void actionHandleHeightUpdate(BuildContext context) async {
    String result =
        await UserAuthentication.insertHeight(widget.userId, height);

    if (result == 'success') {
      print('Height added successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeightPage(userId: widget.userId),
        ),
      );
    } else {
      // Handle error updating height
      print('Error updating height: $result');
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
                child: HeightPicker(
                  onHeightChanged: updateHeight,
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
                    style: button_next,
                    onPressed: () {
                      actionHandleHeightUpdate(context);
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
  final Function(int) onHeightChanged;

  HeightPicker({required this.onHeightChanged});

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  // Initial selected height
  int selectedHeight = 170;

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
          final newHeight = 120 + index;
          widget.onHeightChanged(newHeight);
          setState(() {
            selectedHeight = newHeight;
          });
        },
        itemExtent: 50,
        children: List.generate(130, (index) {
          final height = 120 + index;
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
