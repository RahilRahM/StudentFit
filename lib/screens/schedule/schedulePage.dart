import 'package:intl/intl.dart';
import 'schedule_widgets/event.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'schedule_widgets/addEventForm.dart';
import 'package:student_fit/commons/colors.dart';
import 'package:calendar_view/calendar_view.dart';

// SchedulePage class that is a StatefulWidget
class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => ScheduleState();
}

// ScheduleState class that holds the state for SchedulePage
class ScheduleState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      // Use EventController as the calendar controller
      controller: EventController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: CustomAppBar2(
            appBarTitle: 'Schedule',
            showFavoriteIcon: false,
            leadingIcon: Icons.arrow_back_ios,
            onLeadingPressed: () {
              Navigator.pop(context);
            },
            actions: [],
          ),
          body: const Schedule(),
          drawer: buildDrawer(context),
        ),
      ),
    );
  }
}

// Schedule class that is a StatefulWidget
class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

// _ScheduleState class that holds the state for Schedule
class _ScheduleState extends State<Schedule>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // WeekView widget for displaying the calendar week
          WeekView(
            showLiveTimeLineInAllDays: true,
            startDay: WeekDays.sunday,
            // Header styling
            headerStyle: const HeaderStyle(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              headerTextStyle: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16,
              ),
              leftIcon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteColor,
              ),
              rightIcon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            // Function to build the timeline string
            timeLineStringBuilder: (DateTime currentTime,
                {DateTime? secondaryDate}) {
              String formattedTime = DateFormat('HH:mm').format(currentTime);
              return formattedTime;
            },
            // Function to build the day tiles in the week
            weekDayBuilder: (dayIndex) {
              DateTime currentDate = DateTime.now();
              bool isToday = dayIndex.day == currentDate.day &&
                  dayIndex.month == currentDate.month &&
                  dayIndex.year == currentDate.year;
              int dayOfWeek = dayIndex.weekday % 7 + 1;
              Color currentDayColor = const Color.fromARGB(255, 139, 99, 219);
              Color otherDayColor = Colors.transparent;
              String dayAndDate = DateFormat('E dd').format(dayIndex);
              String day = dayAndDate.substring(0, 1);
              String daynumber = dayAndDate.substring(3);
              return WeekDayTile(
                dayIndex: dayOfWeek,
                backgroundColor: isToday ? currentDayColor : otherDayColor,
                displayBorder: false,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isToday ? Colors.white : AppColors.blackColor,
                ),
                weekDayStringBuilder: (dayIndex) => ' $day\n$daynumber',
              );
            },
          ),
          // Floating action button to add events
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                // Show a modal bottom sheet with the EventsPage widget
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.0)),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return EventsPage();
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to get the current DateTime
DateTime get _now => DateTime.now();

// List of CalendarEventData containing sample event data
List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: _now,
    event: Event(title: "Joe's Birthday"),
    title: "Project meeting",
    description: "Today is a project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
];
