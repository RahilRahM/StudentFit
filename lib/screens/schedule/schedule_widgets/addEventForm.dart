import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:student_fit/commons/colors.dart';
import 'package:calendar_view/calendar_view.dart';




class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final _formKey = GlobalKey<FormState>(); // Form key added here

  EventController controller = EventController();
  TextEditingController eventController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController descController = TextEditingController();

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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
                    'Add new event',
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
                  controller: eventController,
                  validator: validateEvent,
                  label: 'Event',
                ),
                const SizedBox(height: 10),
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
            // Cancel Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 19,
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Done Button
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                    // If the form is valid, save the form data.
                  _formKey.currentState!.save();

                  final event = CalendarEventData(
                    color: AppColors.secondaryColor2,
                    title: titleController.text,
                    event: eventController.text,
                    description: descController.text,
                    date: startDate,
                    endDate: endDate,
                    startTime: DateTime(
                      startDate.year,
                      startDate.month,
                      startDate.day,
                      startTime.hour,
                      startTime.minute,
                    ),
                    endTime: DateTime(
                      endDate.year,
                      endDate.month,
                      endDate.day,
                      endTime.hour,
                      endTime.minute,
                    ),
                    
                  );
                  CalendarControllerProvider.of(context).controller.add(event);
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
                'Done',
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

  String? validateEvent(String? value) {
    if (value == null || value.isEmpty) {
      return 'Event cannot be empty';
    }
    return null;
  }

  String? validateStartDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Start date cannot be empty';
    }

    DateTime? date;
    try {
      date = DateFormat.yMd().parse(value);
    } catch (e) {
      date = null;
    }

    if (date == null) {
      return 'Invalid start date';
    }

    return null;
  }

  String? validateEndDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'End date cannot be empty';
    }

    DateTime? date;
    try {
      date = DateFormat.yMd().parse(value);
    } catch (e) {
      date = null;
    }

    if (date == null) {
      return 'Invalid end date';
    }

    return null;
  }

  String? validateStartTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Start time cannot be empty';
    }

    List<String> timeParts = value.split(':');
    if (timeParts.length != 2) {
      return 'Invalid start time';
    }

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return 'Invalid start time';
    }

    return null;
  }

  String? validateEndTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'End time cannot be empty';
    }

    List<String> timeParts = value.split(':');
    if (timeParts.length != 2) {
      return 'Invalid end time';
    }

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return 'Invalid end time';
    }

    return null;
  }
}

// ignore: must_be_immutable
class Textinput extends StatelessWidget {
  Textinput({
    Key? key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.line = 1,
    this.onTap,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  TextEditingController controller;
  String label;
  int line;
  IconData? prefixIcon;
  Function()? onTap;
  bool readOnly;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: line,
      onTap: onTap,
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
        ),
        fillColor: const Color(0xFFE3E3E3),
        filled: true,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        contentPadding: const EdgeInsets.all(10.0),
        labelStyle: const TextStyle(
          color: Color(0xFF787878),
          fontSize: 14,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      textAlign: TextAlign.start,
    );
  }
}

