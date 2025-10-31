import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const KieAiTesterApp());
}

class KieAiTesterApp extends StatelessWidget {
  const KieAiTesterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kie.ai API Tester',
      debugShowCheckedModeBanner: true, // Show debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

