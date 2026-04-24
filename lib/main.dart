import 'package:flutter/material.dart';
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
          seedColor: Colors.blue,
          brightness: Brightness.dark
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF181A20),
        appBarTheme: AppBarThemeData(
          backgroundColor: Color(0xFF181A20),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500
          )
        )
      ),
      home: const ShellScreen(),
    );
  }
}
