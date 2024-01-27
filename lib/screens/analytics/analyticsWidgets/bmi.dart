import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:StudentFit/commons/colors.dart';
import 'package:StudentFit/main.dart';
import '../../../utils/infoAuth.dart';

class BMICalculatorWidget extends StatefulWidget {
  final Function(String) onTimeframeChanged;
  const BMICalculatorWidget({Key? key, required this.onTimeframeChanged})
      : super(key: key);

  @override
  _BMICalculatorWidgetState createState() => _BMICalculatorWidgetState();
}

class _BMICalculatorWidgetState extends State<BMICalculatorWidget> {
  late int _height;
  late int _weight;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    String? userInfoString = prefs?.getString('user_info');
    if (userInfoString != null) {
      Map<String, dynamic> userInfo = jsonDecode(userInfoString);
      _height = userInfo['height'] ?? 170;
      _weight = userInfo['weight'] ?? 70;
    } else {
      _height = 170; // Default height
      _weight = 70; // Default weight
    }
  }

  double calculateBMI() {
    return _weight / ((_height / 100) * (_height / 100));
  }

  String getBMIStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else if (bmi >= 30) {
      return 'Obese';
    }
    return '';
  }

  double calculateBMIPosition() {
    const double minBMI = 15.0;
    const double maxBMI = 40.0;
    double bmi = calculateBMI();

    bmi = bmi.clamp(minBMI, maxBMI);

    const double scaleWidth = 0.47;
    double scalePosition = (bmi - minBMI) / (maxBMI - minBMI) * scaleWidth;

    return scalePosition.clamp(0.0, scaleWidth);
  }

  Color getBMIColor(double bmi) {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi >= 18.5 && bmi < 25) {
      return Colors.green;
    } else if (bmi >= 25 && bmi < 30) {
      return Colors.orange;
    } else if (bmi > 40) {
      return Colors.red;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.35,
      padding: const EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 0.4 * screenWidth,
                height: screenHeight * 0.08,
                child: const Center(
                  child: Text(
                    "BMI\nCalculator",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: 0.34 * screenWidth,
                height: screenHeight * 0.06,
                padding: const EdgeInsets.only(right: 15),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFC9C9C9)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: DropdownButton<String>(
      value: "this week",
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.grey), // Change to grey
      underline: Container(
        height: 2,
        color: Colors.grey, // Change underline to grey
      ),
      onChanged: (String? newValue) {
        if (newValue != null) {
          widget.onTimeframeChanged(newValue);
        }
      },
      items: <String>['this week', 'this month', 'this year']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black)), // Text color to black
        );
      }).toList(),
    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _showInputDialog(context, "Height"),
                    child: Container(
                      width: 0.36 * screenWidth,
                      height: screenHeight * 0.09,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBB84E8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MeterDesign(),
                          Text(
                            "Height $_height cm",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _showInputDialog(context, "Weight"),
                    child: Container(
                      width: 0.36 * screenWidth,
                      height: screenHeight * 0.09,
                      decoration: BoxDecoration(
                        color: const Color(0xFFAAAAAA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MeterDesign(),
                          Text(
                            "Weight ${_weight.toStringAsFixed(2)} Kg",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Column(
                children: [
                  Container(
                    width: 0.5 * screenWidth,
                    height: screenHeight * 0.22,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE3E3E3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Body Mass Index\n(BMI)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              calculateBMI().toStringAsFixed(2),
                              style: const TextStyle(
                                color: Color(0xFF202525),
                                fontSize: 16,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.04,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: ShapeDecoration(
                                color: getBMIColor(calculateBMI()),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  getBMIStatus(calculateBMI()),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: screenWidth * calculateBMIPosition()),
                              width: 5,
                              height: 5,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD16564),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: Color(0xFF202525),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: screenWidth * 0.47,
                              height: screenHeight * 0.02,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(1.00, 0.00),
                                  end: Alignment(-1, 0),
                                  colors: [
                                    Color(0xFFE2788E),
                                    Color(0xFFE7D284),
                                    Color(0xFF81E5DA),
                                    Color(0xFFB4D4F1),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: screenWidth * 0.47 * 0.0,
                                    bottom: 0,
                                    child: const Text('15',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.47 * 0.14,
                                    bottom: 0,
                                    child: const Text('18.5',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.47 * 0.4,
                                    bottom: 0,
                                    child: const Text('25',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.47 * 0.6,
                                    bottom: 0,
                                    child: const Text('30',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.47 * 0.9,
                                    bottom: 0,
                                    child: const Text('40',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showInputDialog(BuildContext context, String title) async {
    TextEditingController controller = TextEditingController();
    String inputLabel = title == "Height" ? "Height (cm)" : "Weight (Kg)";
    bool showError = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title == "Height" ? "Edit $title" : "Add New $title"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: inputLabel,
                  errorText: showError ? 'Invalid $title' : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: showError ? Colors.red : AppColors.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: showError ? Colors.red : Color(0xFFC9C9C9)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    showError = false;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel',
                        style: TextStyle(color: AppColors.primaryColor)),
                  ),
                  TextButton(
                    onPressed: () async {
                      String inputText = controller.text;
                      if (inputText.isNotEmpty && isNumeric(inputText)) {
                        int inputValue = int.parse(inputText);
                        if (title == 'Height' &&
                            inputValue > 50 &&
                            inputValue < 250) {
                          await InfoAuth.updateHeightRecord(inputValue);
                          if (mounted) {
                            setState(() => _height = inputValue);
                            Navigator.pop(context);
                          }
                        } else if (title == 'Weight' &&
                            inputValue > 20 &&
                            inputValue < 300) {
                          // Save weight record
                          await InfoAuth.saveWeightRecord(inputValue);
                          if (mounted) {
                            setState(() => _weight = inputValue);
                            Navigator.pop(context);
                          }
                        } else {
                          setState(() => showError = true);
                        }
                      } else {
                        setState(() => showError = true);
                      }
                    },
                    child: const Text('OK',
                        style: TextStyle(color: AppColors.primaryColor)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

bool isNumeric(String value) {
  return double.tryParse(value) != null;
}

class MeterDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112.01,
      height: 17.45,
      child: Stack(
        children: List.generate(
          10,
          (index) {
            double leftPosition = 13.72 * index;

            return Positioned(
              left: leftPosition,
              top: -0.08,
              child: Container(
                width: 2.3,
                height: index == 3 ? 13 : 8,
                decoration: ShapeDecoration(
                  color:
                      index % 3 == 0 ? const Color(0xFFD16564) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
