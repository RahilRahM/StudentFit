import 'package:flutter/material.dart';

class TodayTextWidget extends StatelessWidget {
  final TextStyle textStyle;

  const TodayTextWidget({Key? key, required this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0.05 * MediaQuery.of(context).size.width,
        top: 0.01 * MediaQuery.of(context).size.width,
      ),
      child: Text(
        'Today',
        style: textStyle,
      ),
    );
  }
}
