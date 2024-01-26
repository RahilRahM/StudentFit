import 'package:intl/intl.dart';
import '../../../commons/colors.dart';
import 'package:flutter/material.dart';
import './schedule_widgets/event.dart';
import 'schedule_widgets/calendar.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<CalendarEventData<Event>> events = [];
  CalendarFormat calendarFormat = CalendarFormat.month;
  final EventController calendarController = EventController();

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    // Populate your events list here
    // This is an example, replace it with your actual event loading logic
    events = [
      CalendarEventData(
        title: "Test Event",
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 2)),
        date: DateTime.now(),
      ),
      // Add more events as needed
    ];
  }

  List<Widget> _buildEventWidgets() {
    return events.map((event) {
      final startTime = event.startTime != null
          ? DateFormat('h:mm a').format(event.startTime!)
          : 'Unknown Time';
      final endTime = event.endTime != null
          ? DateFormat('h:mm a').format(event.endTime!)
          : 'Unknown Time';
      final date = event.date != null
          ? DateFormat('MMM d, yyyy').format(event.date)
          : 'Unknown Date';
      return EventWidget(
        title: event.title,
        time: "$startTime - $endTime",
        date: date,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> eventWidgets = _buildEventWidgets();
    return Scaffold(
      appBar: const CustomAppBar2(appBarTitle: "Calendar", actions: []),
      backgroundColor: Colors.white,
      drawer: buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DateView(),
                const SizedBox(width: 20),
                ButtonView(
                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Calendar(calendarFormat: calendarFormat),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: eventWidgets.length,
                itemBuilder: (context, index) {
                  return eventWidgets[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventWidget extends StatelessWidget {
  final String title;
  final String time;
  final String date;

  const EventWidget({
    required this.title,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 92, 92, 174),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.event,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                _buildDayNumberColumn(context),
                const SizedBox(width: 12.0),
                _buildDayAlphabetAndMonthYearColumn(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayNumberColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getCurrentDayNumber(),
          style: _textStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.w500,
              color: AppColors.grey3),
        ),
      ],
    );
  }

  Widget _buildDayAlphabetAndMonthYearColumn() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText(_getCurrentDayAlphabet(), AppColors.grey2),
          _buildText(_getCurrentMonthYear(), AppColors.grey2),
        ],
      ),
    );
  }

  Widget _buildText(String text, Color color) {
    return Text(
      text,
      style:
          _textStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: color),
    );
  }

  String _getCurrentDayNumber() {
    return '${DateTime.now().day}';
  }

  String _getCurrentDayAlphabet() {
    return DateFormat('EEEE', 'en_US').format(DateTime.now());
  }

  String _getCurrentMonthYear() {
    return DateFormat('MMM y').format(DateTime.now());
  }

  TextStyle _textStyle({
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

class ButtonView extends StatefulWidget {
  final Function(CalendarFormat) onFormatChanged;

  const ButtonView({Key? key, required this.onFormatChanged}) : super(key: key);

  @override
  _ButtonViewState createState() => _ButtonViewState();
}

class _ButtonViewState extends State<ButtonView> {
  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _toggleButtonText();
        widget.onFormatChanged(calendarFormat);
      },
      style: _elevatedButtonStyle(),
      child: Text(
        calendarFormat == CalendarFormat.month ? 'Month' : 'Week',
        style: const TextStyle(
          color: AppColors.secondaryColor2,
          fontSize: 22.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  ButtonStyle _elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      maximumSize: const Size(150.0, 50.0),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  void _toggleButtonText() {
    setState(() {
      calendarFormat = calendarFormat == CalendarFormat.month
          ? CalendarFormat.week
          : CalendarFormat.month;
    });
  }
}
