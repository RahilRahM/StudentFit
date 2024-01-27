import 'package:flutter/material.dart';
import 'package:StudentFit/commons/colors.dart';
import 'package:table_calendar/table_calendar.dart';

// Calendar widget with TableCalendar
class Calendar extends StatefulWidget {
  final CalendarFormat calendarFormat;

  const Calendar({Key? key, required this.calendarFormat}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

// State class for the Calendar widget
class _CalendarState extends State<Calendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container styling
      padding: EdgeInsets.only(bottom: 20, left: 5, right: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey1,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TableCalendar(
        // TableCalendar properties
        firstDay: DateTime(2000),
        lastDay: DateTime(2101),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Update selected and focused days
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        headerStyle: HeaderStyle(
          // Header styling
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            color: AppColors.secondaryColor2,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          // Days of the week text style
          weekdayStyle: WeekDaysTextStyle(),
          weekendStyle: WeekDaysTextStyle(),
        ),
        onFormatChanged: (format) {
          if (widget.calendarFormat != format) {
            // Handle format change if needed
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarFormat: widget.calendarFormat,
        availableCalendarFormats: {
          CalendarFormat.month: 'Week',
          CalendarFormat.week: 'Month',
        },
      ),
    );
  }

  // TextStyle for days of the week
  TextStyle WeekDaysTextStyle() {
    return const TextStyle(
      fontFamily: 'Raleway',
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: AppColors.grey2,
    );
  }
}
