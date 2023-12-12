import '../../../commons/colors.dart';
import 'package:flutter/material.dart';

class CustomSubBox extends StatefulWidget {
  final String text;
  final String time;
  final bool isSelected;
  final Function() onTap;

  CustomSubBox({
    required this.text,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _CustomSubBoxState createState() => _CustomSubBoxState();
}

class _CustomSubBoxState extends State<CustomSubBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 9.0),
        width: 0.9 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? AppColors.primaryColor
              : const Color.fromARGB(255, 229, 229, 229),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 0.14 * MediaQuery.of(context).size.width,
                vertical: 0.02 * MediaQuery.of(context).size.width,
              ),
              width: 0.5 * MediaQuery.of(context).size.width,
              height: 0.1 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                  color:
                      widget.isSelected ? Colors.white : AppColors.blackColor,
                  fontSize: 19.0,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: 0.3 * MediaQuery.of(context).size.width,
              height: 0.1 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  widget.time,
                  style: TextStyle(
                    color:
                        widget.isSelected ? Colors.white : AppColors.blackColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBox2 extends StatefulWidget {
  @override
  _CustomBox2State createState() => _CustomBox2State();
}

class _CustomBox2State extends State<CustomBox2> {
  int selectedBoxIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            'What is for today ?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 0.04 * MediaQuery.of(context).size.width,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              height: 0.09,
            ),
          ),
        ),
        Container(
          width: 0.8 * MediaQuery.of(context).size.width,
          height: 0.6 * MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: 0.04 * MediaQuery.of(context).size.width,
            left: 0.01 * MediaQuery.of(context).size.width,
            right: 0.01 * MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.001 * MediaQuery.of(context).size.width,
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              CustomSubBox(
                text: 'Breakfast',
                time: '07:40 - 08:00',
                isSelected: selectedBoxIndex == 0,
                onTap: () {
                  onBoxTap(0);
                },
              ),
              CustomSubBox(
                text: 'School',
                time: '08:30 - 13:20',
                isSelected: selectedBoxIndex == 1,
                onTap: () {
                  onBoxTap(1);
                },
              ),
              CustomSubBox(
                text: 'Lunch',
                time: '13:40 - 14:40',
                isSelected: selectedBoxIndex == 2,
                onTap: () {
                  onBoxTap(2);
                },
              ),
              CustomSubBox(
                text: 'Workout',
                time: '15:30 - 16:00',
                isSelected: selectedBoxIndex == 3,
                onTap: () {
                  onBoxTap(3);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onBoxTap(int index) {
    setState(() {
      selectedBoxIndex = index;
    });
  }
}
