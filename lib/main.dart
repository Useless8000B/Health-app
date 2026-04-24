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
      theme: ThemeData.dark(),
      home: const ShellScreen(),
    );
  }
}
