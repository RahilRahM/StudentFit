import 'dart:convert';
import './event.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:student_fit/commons/colors.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_fit/screens/schedule/schedulePage.dart';
import 'package:student_fit/screens/schedule/schedule_widgets/addEventForm.dart';

class EditEventPage extends StatefulWidget {
  final EventController<Event> eventController;
  final CalendarEventData<Event> event;

  const EditEventPage({Key? key, required this.eventController, required this.event})
      : super(key: key);

  @override
  State<EditEventPage> createState() => _EditEventPage();
}

class _EditEventPage extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    // Populate the fields with the event data
    titleController.text = widget.event.title;
    descController.text = widget.event.description;
    startDateController.text = DateFormat.yMd().format(widget.event.date);
    endDateController.text = DateFormat.yMd().format(widget.event.endDate);

  }

  Future<void> _updateEvent(
    CalendarEventData<Event> newEvent,
    Recurrence recurrence,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedEvents = prefs.getStringList('savedEvents') ?? [];

    // Assuming you have a unique way to identify events, such as by title
    int eventIndex = savedEvents.indexWhere((jsonString) {
      final existingEvent = jsonToEvent(jsonDecode(jsonString));
      return existingEvent.title == widget.event.title; // Use a unique identifier here
    });

    if (eventIndex != -1) {
      savedEvents[eventIndex] = jsonEncode(
        eventToJson(newEvent, recurrence),
      );
      await prefs.setStringList('savedEvents', savedEvents);
      // Update the UI and event controller as necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 130),
                const Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    'Edit event',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Textinput(
                  controller: titleController,
                  validator: validateTitle,
                  label: 'Title',
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Textinput(
                        controller: startDateController,
                        label: 'Start Date',
                        prefixIcon: Icons.calendar_month,
                        onTap: () {
                          _selectDate(context, true);
                        },
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Textinput(
                        controller: endDateController,
                        label: 'End Date',
                        prefixIcon: Icons.calendar_month,
                        onTap: () {
                          _selectDate(context, false);
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Textinput(
                        controller: startTimeController,
                        label: 'Start Time',
                        prefixIcon: Icons.schedule,
                        onTap: () {
                          _selectTime(context, true);
                        },
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Textinput(
                        controller: endTimeController,
                        prefixIcon: Icons.schedule,
                        label: 'End Time',
                        onTap: () {
                          _selectTime(context, false);
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Textinput(
                  controller: descController,
                  label: 'Description',
                  line: 5,
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  DateTime startDateTime = DateTime(
                    startDate.year,
                    startDate.month,
                    startDate.day,
                    startTime.hour,
                    startTime.minute,
                  );
            
                  DateTime endDateTime = DateTime(
                    endDate.year,
                    endDate.month,
                    endDate.day,
                    endTime.hour,
                    endTime.minute,
                  );
                  CalendarEventData<Event> updatedEvent = CalendarEventData<Event>(
                    title: titleController.text,
                    event: Event(title: titleController.text, id: ''),
                    description: descController.text,
                    date: startDate,
                    endDate: endDate,
                    startTime: startDateTime,
                    endTime: endDateTime,
                  );

                  // Call the update method, assuming the recurrence is 'oneDay'
                  await _updateEvent(updatedEvent, Recurrence.oneDay);

                  // Pop the current screen
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 19,
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool time) async {
    final setTime = time ? startTime : endTime;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: setTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              // change the border color
              primary: AppColors.secondaryColor2,
              // change the text color
              onSurface: AppColors.grey4,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != setTime) {
      setState(() {
        if (time) {
          startTime = pickedTime;
          startTimeController.text = pickedTime.format(context).toString();
        } else {
          endTime = pickedTime;
          endTimeController.text = pickedTime.format(context).toString();
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool date) async {
    final setDate = date ? startDate : endDate;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.secondaryColor2,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.secondaryColor2, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != setDate) {
      setState(() {
        if (date) {
          startDate = pickedDate;
          startDateController.text = DateFormat.yMMMd().format(pickedDate);
        } else {
          endDate = pickedDate;
          endDateController.text = DateFormat.yMMMd().format(pickedDate);
        }
      });
    }
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title cannot be empty';
    }
    return null;
  }
}
