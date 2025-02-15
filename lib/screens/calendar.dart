import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import '/widgets/footer.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  PageController _pageController = PageController(initialPage: 1);
  DateTime _selectedDate = DateTime.now();
  int _currentDotIndex = 1;
  List<String> _holidays = []; // Store holidays

  final clientId = ClientId(
    'YOUR_CLIENT_ID',
    'YOUR_CLIENT_SECRET',
  ); // Replace with your client ID and secret
  final scopes = [calendar.CalendarApi.calendarScope];

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  // Authenticate the user and fetch holidays
  Future<void> _authenticate() async {
    try {
      await clientViaUserConsent(clientId, scopes, (uri) {
        print("Please go to the following URL and grant access:");
        print("  => $uri");
      }).then((AuthClient client) {
        _fetchHolidays(client);
      });
    } catch (e) {
      print("Authentication failed: $e");
    }
  }

  // Fetch Holidays from Google Calendar API
  Future<void> _fetchHolidays(AuthClient client) async {
    String calendarId =
        "en.srilanka#holiday@group.v.calendar.google.com"; // Sri Lanka Holidays calendar
    String apiUrl =
        "https://www.googleapis.com/calendar/v3/calendars/$calendarId/events";

    try {
      final response = await client.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> items = jsonResponse['items'] ?? [];

        setState(() {
          _holidays = items
              .map(
                (event) =>
                    "${event['summary']} - ${_formatDate(event['start']['date'])}",
              )
              .toList();
        });
      } else {
        print("Failed to fetch holidays: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching holidays: $e");
    }
  }

  // Format Date from YYYY-MM-DD to MM/DD
  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.month}/${parsedDate.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                if (index == 0) {
                  _changeMonth(-1);
                  _pageController.jumpToPage(1);
                } else if (index == 2) {
                  _changeMonth(1);
                  _pageController.jumpToPage(1);
                }
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [_buildCalendar(), _buildMonthSelector()],
                );
              },
            ),
          ),
          _buildHolidaysList(),
          const Footer(), // Footer Component
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Column(
      children: [
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${_getMonthName(_selectedDate.month)} ${_selectedDate.year}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: _currentDotIndex == index ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget _buildCalendar() {
    int daysInMonth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    int firstWeekday =
        DateTime(_selectedDate.year, _selectedDate.month, 1).weekday;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(6),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.4,
      ),
      itemCount: daysInMonth + (firstWeekday - 1),
      itemBuilder: (context, index) {
        if (index < firstWeekday - 1) {
          return const SizedBox();
        }
        int day = index - (firstWeekday - 2);
        return Center(
          child: Text(
            "$day",
            style: TextStyle(
              fontSize: 12,
              color: (index % 7 == 5 || index % 7 == 6)
                  ? Colors.grey
                  : Colors.black,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHolidaysList() {
    return _holidays.isNotEmpty
        ? Column(
            children: [
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _holidays.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _holidays[index],
                      style: const TextStyle(fontSize: 12),
                    ),
                    leading: const Icon(
                      Icons.event,
                      color: Colors.green,
                      size: 18,
                    ),
                  );
                },
              ),
            ],
          )
        : const SizedBox();
  }

  void _changeMonth(int increment) {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + increment,
        1,
      );
      _currentDotIndex = increment < 0 ? 0 : (increment > 0 ? 2 : 1);
    });
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }
}
