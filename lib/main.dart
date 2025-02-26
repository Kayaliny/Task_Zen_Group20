import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/task_form.dart';
import 'screens/task_list.dart';
import 'screens/calendar.dart';
import 'screens/personal_info_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TaskZen',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const WelcomeScreen(),
          '/taskForm': (context) => const TaskForm(),
          '/taskList': (context) => const TaskListScreen(),
          '/calendar': (context) => const CalendarPage(),
          '/profile': (context) => const PersonalInfoPage(),
        });
  }
}
