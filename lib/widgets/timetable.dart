import 'package:flutter/material.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';
import 'package:stundenplan_app/widgets/timetable_entry.dart';

class Timetable extends StatelessWidget {
  final Future<String> data;

  const Timetable({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null) {
          return const Center(
            child: Text("Es ist ein Fehler aufgetreten."),
          );
        }

        return SingleChildScrollView(
          child: Text(snapshot.data!),
        );
      },
    );

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
