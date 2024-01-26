import 'dart:convert';
import 'package:intl/intl.dart';
import 'schedule_widgets/event.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'schedule_widgets/addEventForm.dart';
import 'package:student_fit/commons/colors.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventWrapper {
  final CalendarEventData<Event> event;
  final Recurrence recurrence;

  EventWrapper(this.event, this.recurrence);

  Map<String, dynamic> toJson() => {
        'event': eventToJson(event, recurrence), // Use the updated eventToJson
        'recurrence':
            recurrence == Recurrence.everyWeek ? 'everyWeek' : 'oneDay',
      };

  static EventWrapper fromJson(Map<String, dynamic> json) {
    return EventWrapper(
      jsonToEvent(json['event']),
      json['recurrence'] == 'everyWeek'
          ? Recurrence.everyWeek
          : Recurrence.oneDay,
    );
  }
}

// SchedulePage class that is a StatefulWidget
class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => ScheduleState();
}

// ScheduleState class that holds the state for SchedulePage
class ScheduleState extends State<SchedulePage> {
  final EventController<Event> eventController = EventController<Event>();

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> savedEvents = prefs.getStringList('savedEvents') ?? [];
      for (String jsonString in savedEvents) {
        final event = jsonToEvent(jsonDecode(jsonString));
        eventController.add(event);
      }
    } catch (e) {
      print("Error loading events: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      // Use EventController as the calendar controller
      controller: eventController,
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
          body: Schedule(eventController: eventController),
          drawer: buildDrawer(context),
        ),
      ),
    );
  }
}

// Schedule class that is a StatefulWidget
class Schedule extends StatefulWidget {
  final EventController<Event> eventController;

  const Schedule({Key? key, required this.eventController}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

// _ScheduleState class that holds the state for Schedule
class _ScheduleState extends State<Schedule>
    with SingleTickerProviderStateMixin {
  Future<void> _saveEvent(
      CalendarEventData<Event> event, Recurrence recurrence) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedEvents = prefs.getStringList('savedEvents') ?? [];
    savedEvents.add(jsonEncode(eventToJson(event, recurrence)));
    await prefs.setStringList('savedEvents', savedEvents);
  }

  Future<void> _loadEvents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> savedEvents = prefs.getStringList('savedEvents') ?? [];
      for (String jsonString in savedEvents) {
        final jsonData = jsonDecode(jsonString);
        if (jsonData != null && jsonData is Map<String, dynamic>) {
          final event = jsonToEvent(jsonData);
        } else {
          print('Invalid or null JSON data encountered');
        }
      }
    } catch (e) {
      print("Error loading events: $e");
    }
  }

  void _onEventTap(CalendarEventData<Event> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Description: ${event.description}'),
                Text(
                    'Start Time: ${event.startTime != null ? DateFormat('yyyy-MM-dd – kk:mm').format(event.startTime!) : 'Not specified'}'),
                Text(
                    'End Time: ${event.endTime != null ? DateFormat('yyyy-MM-dd – kk:mm').format(event.endTime!) : 'Not specified'}'),
                // You can add more details here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          WeekView(
            controller: CalendarControllerProvider.of<Event>(context).controller,
            showLiveTimeLineInAllDays: true,
            startDay: WeekDays.sunday,
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
                color: AppColors.whiteColor,
              ),
            ),
            timeLineStringBuilder: (DateTime currentTime,
                {DateTime? secondaryDate}) {
              String formattedTime = DateFormat('HH:mm').format(currentTime);
              return formattedTime;
            },
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
            eventTileBuilder: (context, events, bounds, start, end) {
              if (events.isNotEmpty) {
                CalendarEventData<Event> event = events.first;
            
                return GestureDetector(
                  onTap: () => _onEventTap(event),
                  child: Container(
                    width: bounds.width,
                    height: bounds.height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: event.color ?? Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      event.title,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return Container();  // Return an empty container for empty 'events' list
            },                                    
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.0)),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return EventsPage(
                        eventController:
                            widget.eventController); // Pass the controller
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

Map<String, dynamic> eventToJson(
    CalendarEventData<Event> event, Recurrence recurrenceType) {
  return {
    'title': event.title,
    'description': event.description,
    'date': event.date.toIso8601String(),
    'endDate': event.endDate.toIso8601String(),
    'startTime': event.startTime?.toIso8601String(),
    'endTime': event.endTime?.toIso8601String(),
    'recurrence':
        recurrenceType == Recurrence.everyWeek ? 'everyWeek' : 'oneDay',
  };
}

CalendarEventData<Event> jsonToEvent(Map<String, dynamic> jsonData) {
  var recurrenceType = jsonData['recurrence'] == 'everyWeek'
      ? Recurrence.everyWeek
      : Recurrence.oneDay;

  return CalendarEventData<Event>(
    title: jsonData['title'],
    description: jsonData['description'],
    date: DateTime.parse(jsonData['date']),
    endDate: DateTime.parse(jsonData['endDate']),
    startTime: jsonData['startTime'] != null
        ? DateTime.parse(jsonData['startTime'])
        : null,
    endTime: jsonData['endTime'] != null
        ? DateTime.parse(jsonData['endTime'])
        : null,
    color: recurrenceType == Recurrence.everyWeek
        ? AppColors.secondaryColor
        : AppColors.primaryColor,
  );
}

CalendarEventData<Event> copyEventWithNewDate(
    CalendarEventData<Event> event, DateTime newDate) {
  return CalendarEventData<Event>(
    color: event.color,
    title: event.title,
    event: event.event,
    description: event.description,
    date: newDate,
    endDate: newDate.add(Duration(hours: 1)),
    startTime: newDate,
    endTime: newDate.add(Duration(hours: 1)),
  );
}
