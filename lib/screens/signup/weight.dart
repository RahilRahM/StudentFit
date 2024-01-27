import 'style.dart';
import '../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/userAuthentication.dart';
import 'package:StudentFit/screens/home/homepage.dart';

class WeightPage extends StatefulWidget {
  final int userId;

  WeightPage({required this.userId});

  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int weight = 60;

  void updateWeight(int newWeight) {
    setState(() {
      weight = newWeight;
    });
  }

  void actionHandleWeightUpdate(BuildContext context) async {
    String result =
        await UserAuthentication.insertWeight(widget.userId, weight);

    if (result == 'success') {
      print('Weight added successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(appBarTitle: 'Home'),
        ),
      );
    } else {
      // Handle error updating weight
      print('Error updating weight: $result');
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
                child: WeightPicker(
                  onWeightChanged: updateWeight,
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
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    style: button_next,
                    onPressed: () {
                      actionHandleWeightUpdate(context);
                    },
                    child: const Text('Continue'),
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
  final Function(int) onWeightChanged;

  WeightPicker({required this.onWeightChanged});

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
      widget.onWeightChanged(selectedWeight);
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
          const SizedBox(
            height: 10,
          ),
          Text(
            weight.toString(),
            style: _getWeightTextStyle(weight),
          ),
          if (weight == selectedWeight)
            const Icon(
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
      return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryColor2,
      );
    } else if (weight == selectedWeight + 1 || weight == selectedWeight - 1) {
      return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 27,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 0.51),
      );
    } else if (weight == selectedWeight + 2 || weight == selectedWeight - 2) {
      return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 23,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(0, 0, 0, 0.3),
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
