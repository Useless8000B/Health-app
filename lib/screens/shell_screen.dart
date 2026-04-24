import 'package:flutter/material.dart';
import 'package:health/navigation/drawer_navigator.dart';
import 'package:health/screens/about_screen.dart';
import 'package:health/screens/schedule_exam_screen.dart';
import 'package:health/screens/scheduled_exams_screen.dart';
import 'package:health/screens/services_screen.dart';
import 'package:health/screens/settings_screen.dart';
import 'package:health/widgets/appbar_widget.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    ServicesScreen(),
    ScheduleExamScreen(),
    ScheduledExamsScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  void navigate(int index) {
    setState(() {
      Navigator.pop(context);
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: DrawerNavigator(currentIndex: currentIndex, onTap: navigate),
      body: SafeArea(
        child: IndexedStack(index: currentIndex, children: _pages),
      ),
    );
  }
}
