import 'package:flutter/material.dart';
import 'package:stundenplan_app/services/crawler.dart';
import 'package:stundenplan_app/widgets/day_dropdown.dart';
import 'package:stundenplan_app/widgets/timetable.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DayDropdown(),
              Row(
                children: [
                  Switch(value: false, onChanged: (bool? newValue) {}),
                  const Text("Stundenplanänderungen"),
                ],
              ),
              const Expanded(
                child: Timetable(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
