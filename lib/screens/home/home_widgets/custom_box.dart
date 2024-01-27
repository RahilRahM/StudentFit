import '../../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../../tracker/water_details.dart';
import '../../tracker/calories_details.dart';
import 'package:StudentFit/screens/schedule/schedulePage.dart';

class CustomBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.01 * MediaQuery.of(context).size.width,
      height: 0.4 * MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: 0.05 * MediaQuery.of(context).size.width,
        left: 0.03 * MediaQuery.of(context).size.width,
        right: 0.03 * MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.0006 * MediaQuery.of(context).size.width,
          color: AppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0.02 * MediaQuery.of(context).size.width,
            top: 0.02 * MediaQuery.of(context).size.width,
            child: Text(
              "Today's Progress",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 0.04 * MediaQuery.of(context).size.width,
                fontWeight: FontWeight.w600,
                height: 20 / 13,
                letterSpacing: 0,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubBox(icon: Icons.schedule, label: 'Schedule'),
              SubBox(icon: Icons.water_drop, label: 'Water'),
              SubBox(icon: Icons.whatshot, label: 'Calories'),
            ],
          ),
        ],
      ),
    );
  }
}

class SubBox extends StatefulWidget {
  final IconData icon;
  final String label;

  SubBox({required this.icon, required this.label});

  @override
  _SubBoxState createState() => _SubBoxState();
}

class _SubBoxState extends State<SubBox> {
  bool isTapped = false;

  void _navigateToPage() {
    switch (widget.label.toLowerCase()) {
      case 'water':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WaterPage()));
        break;
      case 'schedule':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SchedulePage()));
        break;
      case 'calories':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CaloriesDetailPage(
                      recipeData: {
                        'path': 'assets/images/snack1.jpeg',
                        'title': 'Healthy Salad',
                      },
                    )));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
          _navigateToPage(); // Navigate when tapped
        });
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isTapped
            ? 0.2 * MediaQuery.of(context).size.width
            : 0.19 * MediaQuery.of(context).size.width,
        height: isTapped
            ? 0.26 * MediaQuery.of(context).size.width
            : 0.23 * MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          left: 0.05 * MediaQuery.of(context).size.width,
          right: 0.05 * MediaQuery.of(context).size.width,
          top: 0.14 * MediaQuery.of(context).size.width,
        ),
        padding: EdgeInsets.all(0.02 * MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.89),
          color: AppColors.greyColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColorHome,
              blurRadius: isTapped ? 8 : 4,
              offset: isTapped ? const Offset(0, 8) : const Offset(0, 4),
              spreadRadius: isTapped ? 4 : 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.01 * MediaQuery.of(context).size.width),
            Icon(
              widget.icon,
              size: 0.07 *
                  MediaQuery.of(context)
                      .size
                      .width, // Adjust the size factor as needed
              color: AppColors.primaryColor,
            ),
            SizedBox(height: 0.05 * MediaQuery.of(context).size.width),
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 0.03 * MediaQuery.of(context).size.width,
                fontWeight: FontWeight.w700,
                height: 20 / 13,
                letterSpacing: 0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
