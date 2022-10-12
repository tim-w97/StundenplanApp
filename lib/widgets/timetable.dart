import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';
import 'package:stundenplan_app/providers/timetable_provider.dart';
import 'package:stundenplan_app/widgets/timetable_entry.dart';

class Timetable extends StatelessWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimetableProvider timetableProvider = context.watch<TimetableProvider>();

    return FutureBuilder(
      future: timetableProvider.timetableData,
      builder: (BuildContext context,
          AsyncSnapshot<List<TimetableEntryData>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Lottie.asset("assets/teacher.json");
        }

        if (snapshot.data == null) {
          return const Center(
            child: Text("Es ist ein Fehler aufgetreten. 😪"),
          );
        }

        if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text("An diesem Tag finden keine Vorlesungen statt. 😎"),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return TimetableEntry(data: snapshot.data![index]);
          },
        );
      },
    );
  }
}
