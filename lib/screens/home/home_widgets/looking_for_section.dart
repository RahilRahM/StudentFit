import '../../../commons/colors.dart';
import 'package:flutter/material.dart';

class ConcreteLookingForSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(
            top: 0.06 * MediaQuery.of(context).size.width,
            left: 0.05 * MediaQuery.of(context).size.width,
          ),
          child: Text(
            'Looking for ?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 0.04 * MediaQuery.of(context).size.width,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              height: 0.09,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.03 * MediaQuery.of(context).size.width,
            vertical: 0.02 * MediaQuery.of(context).size.width,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LookingForBox(
                imagePath: "assets/images/breakfast.png",
                boxTitle: "Breakfast",
              ),
              LookingForBox(
                imagePath: "assets/images/snack.png",
                boxTitle: "Snack",
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.03 * MediaQuery.of(context).size.width,
            vertical: 0.015 * MediaQuery.of(context).size.width,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LookingForBox(
                imagePath: "assets/images/lunch.png",
                boxTitle: "Lunch",
              ),
              LookingForBox(
                imagePath: "assets/images/dinner.png",
                boxTitle: "Dinner",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LookingForBox extends StatefulWidget {
  final String imagePath;
  final String boxTitle;

  LookingForBox({required this.imagePath, required this.boxTitle});

  @override
  _LookingForBoxState createState() => _LookingForBoxState();
}

class _LookingForBoxState extends State<LookingForBox> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
        navigateToPage(context); // Call the method to navigate
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isTapped
            ? 0.45 * MediaQuery.of(context).size.width
            : 0.425 * MediaQuery.of(context).size.width,
        height: isTapped
            ? 0.325 * MediaQuery.of(context).size.width
            : 0.25 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(widget.imagePath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColorHome,
              blurRadius: isTapped ? 8 : 4,
              offset: isTapped ? const Offset(0, 8) : const Offset(0, 4),
              spreadRadius: isTapped ? 4 : 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.boxTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 0.04 * MediaQuery.of(context).size.width,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context) {
    String routeName;

    switch (widget.boxTitle.toLowerCase()) {
      case 'breakfast':
        routeName = '/breakfast';
        break;
      case 'lunch':
        routeName = '/lunch';
        break;
      case 'dinner':
        routeName = '/dinner';
        break;
      case 'snack':
        routeName = '/snack';
        break;
      default:
        return;
    }

    Navigator.pushNamed(context, routeName);
  }
}
