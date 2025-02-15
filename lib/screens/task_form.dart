import 'package:flutter/material.dart';
import '/widgets/calendar_widget.dart';
import '/widgets/footer.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _timeController.text = _formatTime(_selectedTime);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void _handleDateTimeSelected(DateTime date, TimeOfDay time) {
    setState(() {
      _selectedDate = date;
      _selectedTime = time;
      _timeController.text = _formatTime(time);
    });
  }

  void _selectTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = _formatTime(pickedTime);
      });
    }
  }

  void _createTask() {
    print("Task Created: ${_titleController.text}");
    print("Date: $_selectedDate, Time: ${_timeController.text}");
  }

  void _clearFields() {
    _titleController.clear();
    _timeController.clear();
    setState(() {
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add Task")),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add title", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Your title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Select Date and Time", style: TextStyle(fontSize: 16)),
            CalendarWidget(
              selectedDate: _selectedDate,
              onDateTimeSelected: _handleDateTimeSelected,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _createTask,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.94,
                          horizontal: 44.69,
                        ),
                        backgroundColor: const Color(0xFF90B9A4),
                      ),
                      child: const Text("Create Task"),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _clearFields,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.94,
                          horizontal: 44.69,
                        ),
                        backgroundColor: const Color(0xFF90B9A4),
                      ),
                      child: const Text("Clear Fields"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        icon: Icons.add,
        onPressed: () {
          print("Add Task button clicked!");
        },
      ),
    );
  }
}
