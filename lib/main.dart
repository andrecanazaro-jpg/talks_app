import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TalksApp());
}

class TalksApp extends StatelessWidget {
  const TalksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TalksApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFFC8960C),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC8960C),
          secondary: Color(0xFFF0B429),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}