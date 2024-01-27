import '../../../commons/colors.dart';
import 'package:flutter/material.dart';

class CustomSubBox extends StatefulWidget {
  final String text;
  final String time;
  final bool isSelected;
  final Function() onTap;
  final IconData icon;

  CustomSubBox({
    required this.text,
    required this.time,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });

  @override
  _CustomSubBoxState createState() => _CustomSubBoxState();
}

class _CustomSubBoxState extends State<CustomSubBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 9.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: widget.isSelected ? Colors.white : AppColors.primaryColor),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.isSelected ? Colors.white : Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.black,
                fontSize: 16.0,
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
  final List<Map<String, dynamic>> activities = [
    {'text': 'Breakfast', 'time': '07:40 - 08:00', 'icon': Icons.free_breakfast},
    {'text': 'School', 'time': '08:30 - 13:20', 'icon': Icons.school},
    {'text': 'Lunch', 'time': '13:30 - 14:10', 'icon': Icons.lunch_dining},
    {'text': 'Snack', 'time': '15:00 - 15:30', 'icon': Icons.fastfood},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0), // Apply horizontal padding
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'What is for today?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (int i = 0; i < activities.length; i++)
            CustomSubBox(
              text: activities[i]['text'],
              time: activities[i]['time'],
              isSelected: selectedBoxIndex == i,
              onTap: () => onBoxTap(i),
              icon: activities[i]['icon'],
            ),
        ],
      ),
    );
  }

  void onBoxTap(int index) {
    setState(() {
      selectedBoxIndex = index;
    });
  }
}
