import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stundenplan_app/providers/timetable_provider.dart';
import 'package:stundenplan_app/widgets/course_dropdown.dart';
import 'package:stundenplan_app/widgets/day_dropdown.dart';
import 'package:stundenplan_app/widgets/timetable.dart';
import 'package:stundenplan_app/widgets/timetable_changes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimetableProvider timetableProvider = context.watch<TimetableProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CourseDropdown(),
                  const SizedBox(width: 10),
                  if (!timetableProvider.timetableChangesAreVisible)
                    const DayDropdown(),
                ],
              ),
              Row(
                children: [
                  Switch(
                      value: timetableProvider.timetableChangesAreVisible,
                      onChanged: (bool newValue) {
                        timetableProvider
                            .setTimetableChangesVisibilityTo(newValue);
                      }),
                  const Text("Stundenplanänderungen"),
                ],
              ),
              Expanded(
                child: timetableProvider.timetableChangesAreVisible
                    ? const TimetableChanges()
                    : const Timetable(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
