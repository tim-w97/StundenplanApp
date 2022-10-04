import 'package:flutter/material.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';
import 'package:stundenplan_app/widgets/timetable_entry.dart';

class Timetable extends StatelessWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return TimetableEntry(
          data: TimetableEntryData(
            from: "08:00",
            to: "09:30",
            event: "Diskrete Mathematik",
            professor: "Dr. Ashauer",
            room: "B001/B002",
            type: "HR",
          ),
        );
      },
    );
  }
}
