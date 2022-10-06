import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stundenplan_app/providers/timetable_provider.dart';
import 'package:stundenplan_app/screens/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => TimetableProvider(),
      child: const TimetableApp(),
    ),
  );
}

class TimetableApp extends StatelessWidget {
  const TimetableApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HAW Hof Stundenplan',
      theme: ThemeData.dark(),
      routes: {
        "/": (context) => const MainScreen(),
      },
    );
  }
}
