import 'package:flutter/material.dart';
import 'package:stundenplan_app/widgets/course_dropdown.dart';
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
              Row(
                children: const [
                  CourseDropdown(),
                  SizedBox(width: 10),
                  DayDropdown(),
                ],
              ),
              Row(
                children: const [
                  Switch(value: false, onChanged: null),
                  Text("Stundenplanänderungen"),
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
