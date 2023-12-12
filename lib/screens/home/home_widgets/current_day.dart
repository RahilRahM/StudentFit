import 'package:intl/intl.dart';
import '../../../commons/colors.dart';
import 'package:flutter/material.dart';

class CurrentDayWidget extends StatelessWidget {
  final TextStyle textStyle;

  const CurrentDayWidget({Key? key, this.textStyle = const TextStyle()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentDate = getCurrentDate();

    return Padding(
      padding: EdgeInsets.only(
        left: 0.05 * MediaQuery.of(context).size.width,
        top: 0.019 * MediaQuery.of(context).size.width,
      ),
      child: Text(
        currentDate,
        style: textStyle.copyWith(
          fontSize: 0.06 * MediaQuery.of(context).size.width,
          shadows: [
            Shadow(
              offset: const Offset(2, 2),
              color: AppColors.secondaryColor.withOpacity(0.1),
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }

  String getCurrentDate() {
    return DateFormat('MMMM d, yyyy').format(DateTime.now());
  }
}
