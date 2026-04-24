import 'package:flutter/material.dart';

class DrawerNavigator extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const DrawerNavigator({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: onTap,
      selectedIndex: currentIndex,
      children: const [
        NavigationDrawerDestination(
          icon: Icon(Icons.medical_services),
          label: Text('Services'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.schedule),
          label: Text('Schedule Exam'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.assignment_turned_in),
          label: Text('Scheduled Exams'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.info),
          label: Text('About'),
        ),
      ],
    );
  }
}
