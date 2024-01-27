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
import 'package:student_fit/screens/schedule/schedule_widgets/editEventPage.dart';

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
  final EventController<Event> eventController = EventController<Event>();
  Future<void> _saveEvent(
      CalendarEventData<Event> event, Recurrence recurrence) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedEvents = prefs.getStringList('savedEvents') ?? [];
    savedEvents.add(jsonEncode(eventToJson(event, recurrence)));
    await prefs.setStringList('savedEvents', savedEvents);
  }

  Future<void> _deleteEvent(CalendarEventData<Event> event) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> savedEvents = prefs.getStringList('savedEvents') ?? [];
      savedEvents.removeWhere((jsonString) {
        final jsonData = jsonDecode(jsonString);
        final savedEvent = jsonToEvent(jsonData);
        return savedEvent.date == event.date && savedEvent.title == event.title;
      });
      await prefs.setStringList('savedEvents', savedEvents);
      eventController.remove(event);
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  Future<void> _loadEvents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> savedEvents = prefs.getStringList('savedEvents') ?? [];
      for (String jsonString in savedEvents) {
        final jsonData = jsonDecode(jsonString);
        if (jsonData != null && jsonData is Map<String, dynamic>) {
          // ignore: unused_local_variable
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.35,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Event title with the leading colored icon
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5.0,
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        event.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50),

                // Date and time row
                Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.primaryColor),
                    SizedBox(width: 10),
                    Text(
                      '${DateFormat('HH:mm').format(event.startTime!)} – ${DateFormat('HH:mm').format(event.endTime!)}',
                      style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 128, 126, 126)),
                    ),
                  ],
                ),
                Divider(color: Colors.grey[300], thickness: 1, height: 20),
                SizedBox(height: 30),
                Row(
                  children: [
                    Icon(Icons.description, color: AppColors.primaryColor),
                    SizedBox(width: 10),
                    Text(
                      event.description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),

                Divider(color: Colors.grey[300], thickness: 1, height: 20),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                        Icons.edit, 'Edit', AppColors.primaryColor, () {
                      Navigator.pop(context); // Close the bottom sheet first
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEventPage(
                            eventController: widget.eventController,
                            event: event, // Pass the event to be edited
                          ),
                        ),
                      );
                    }),
                    _buildActionButton(Icons.delete, 'Delete', Colors.red, () {
                      _deleteEvent(event); // Call the delete event function
                      Navigator.pop(
                          context); // Close the bottom sheet after deleting
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to build the action buttons
  Widget _buildActionButton(
      IconData icon, String text, Color color, VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(text, style: TextStyle(color: color)),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 18, color: Colors.grey)),
      ],
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
            controller:
                CalendarControllerProvider.of<Event>(context).controller,
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
                      color: event.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      event.title,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return Container(); // Return an empty container for empty 'events' list
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
    'id': event.event?.id,
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

  // Ensure that 'id' is present and is a String. If it's not, you might throw an error or handle it appropriately
  String eventId = jsonData['id'] as String? ??
      'defaultId'; // Replace 'defaultId' with a suitable default or error handling

  return CalendarEventData<Event>(
    event: Event(
      id: eventId, // Use the parsed id
      title:
          jsonData['title'] as String? ?? '', // Default to empty string if null
      description: jsonData['description'] as String?, // Already allows null
    ),
    title:
        jsonData['title'] as String? ?? '', // Default to empty string if null
    description: jsonData['description'] as String, // Already allows null
    date: DateTime.parse(
        jsonData['date'] as String), // Cast as String for type safety
    endDate: DateTime.parse(
        jsonData['endDate'] as String), // Cast as String for type safety
    startTime: jsonData['startTime'] != null
        ? DateTime.parse(
            jsonData['startTime'] as String) // Cast as String for type safety
        : null,
    endTime: jsonData['endTime'] != null
        ? DateTime.parse(
            jsonData['endTime'] as String) // Cast as String for type safety
        : null,
    color: recurrenceType == Recurrence.everyWeek
        ? AppColors.secondaryColor
        : AppColors.primaryColor,
    // ... other fields ...
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
