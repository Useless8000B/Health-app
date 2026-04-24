import 'package:flutter/material.dart';
import 'package:health/colors.dart';
import 'package:health/screens/shell_screen.dart';

void main() {
  runApp(const Health());
}

class Health extends StatelessWidget {
  const Health({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarThemeData(
          backgroundColor: AppColors.background,
          titleTextStyle: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500
          )
        )
      ),
      home: const ShellScreen(),
    );
  }
}
