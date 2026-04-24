import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health/colors.dart';

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
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'Patient Account';

    return NavigationDrawer(
      onDestinationSelected: onTap,
      selectedIndex: currentIndex,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 32, 28, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1503777119540-ce54b422baff?q=80&w=200&auto=format&fit=crop',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userEmail,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.white24),
            ],
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.medical_services_outlined),
          selectedIcon: Icon(Icons.medical_services),
          label: Text('Services'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.schedule_outlined),
          selectedIcon: Icon(Icons.schedule),
          label: Text('Schedule Exam'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.assignment_turned_in_outlined),
          selectedIcon: Icon(Icons.assignment_turned_in),
          label: Text('Scheduled Exams'),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          label: Text('Settings'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.info_outlined),
          label: Text('About'),
        ),
      ],
    );
  }
}