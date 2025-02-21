import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/widgets/footer.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int _selectedTabIndex = 1;

  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Morning Yoga', 'time': '6:00 AM - 7:00 AM', 'completed': true},
    {'title': 'Do Meditation', 'time': '7:30 AM - 8:00 AM', 'completed': true},
    {
      'title': 'Feed the Cats',
      'time': '10:00 AM - 10:30 AM',
      'completed': false,
    },
    {
      'title': 'Water indoor plants',
      'time': '11:00 AM - 11:30 AM',
      'completed': false,
    },
  ];

  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat(
      'EEEE, d MMMM',
    ).format(now);
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Task List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
              const PopupMenuItem(value: "Logout", child: Text("Logout")),
            ],
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabItem(0, "Completed"),
                _buildTabItem(1, "Today's task"),
                _buildTabItem(2, "Upcoming"),
              ],
            ),
          ),

          // Display Current Date
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 8, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's task",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  getFormattedDate(),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          TaskStatusTab(
            allTasks: _tasks.length,
            ongoingTasks: _tasks.where((task) => !task['completed']).length,
            completedTasks: _tasks.where((task) => task['completed']).length,
            onTabSelected: (selectedTab) {
              print("Selected Tab: $selectedTab");
            },
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredTasks().length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        setState(() {
                          _filteredTasks()[index]['completed'] =
                              !_filteredTasks()[index]['completed'];
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _filteredTasks()[index]['completed']
                              ? const Color(
                                  0xFF90B9A4,
                                )
                              : Colors.grey.shade300,
                        ),
                        child: _filteredTasks()[index]['completed']
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      ),
                    ),
                    title: Text(
                      _filteredTasks()[index]['title'],
                      style: TextStyle(
                        decoration: _filteredTasks()[index]['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(_filteredTasks()[index]['time']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(icon: Icons.add),
    );
  }

  List<Map<String, dynamic>> _filteredTasks() {
    if (_selectedTabIndex == 0) {
      return _tasks.where((task) => task['completed']).toList();
    } else if (_selectedTabIndex == 2) {
      return _tasks.where((task) => !task['completed']).toList();
    }
    return _tasks;
  }

  Widget _buildTabItem(int index, String label) {
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: _selectedTabIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: _selectedTabIndex == index ? Colors.black : Colors.grey,
            ),
          ),
          if (_selectedTabIndex == index)
            Container(
              width: 40,
              height: 3,
              color: Colors.black,
              margin: const EdgeInsets.only(top: 4),
            ),
        ],
      ),
    );
  }
}

// Task Status Tab with Counts
class TaskStatusTab extends StatelessWidget {
  final int allTasks;
  final int ongoingTasks;
  final int completedTasks;
  final Function(String) onTabSelected;

  const TaskStatusTab({
    super.key,
    required this.allTasks,
    required this.ongoingTasks,
    required this.completedTasks,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTabItem("All", allTasks, Colors.green, onTabSelected),
          const SizedBox(width: 15),
          const VerticalDivider(thickness: 1, color: Colors.grey),
          const SizedBox(width: 15),
          _buildTabItem("Ongoing", ongoingTasks, Colors.grey, onTabSelected),
          const SizedBox(width: 15),
          _buildTabItem(
            "Completed",
            completedTasks,
            Colors.grey,
            onTabSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    String label,
    int count,
    Color color,
    Function(String) onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 6),
          CircleAvatar(
            radius: 10,
            backgroundColor: color,
            child: Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
