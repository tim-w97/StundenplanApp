import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stundenplan_app/models/timetable_change_entry_data.dart';
import 'package:stundenplan_app/providers/timetable_provider.dart';
import 'package:stundenplan_app/widgets/timetable_change_entry.dart';

class TimetableChanges extends StatelessWidget {
  const TimetableChanges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimetableProvider timetableProvider = context.watch<TimetableProvider>();

    return FutureBuilder(
      future: timetableProvider.timetableChangesData,
      builder: (BuildContext context,
          AsyncSnapshot<List<TimetableChangeEntryData>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null) {
          return const Center(
            child: Text("Es ist ein Fehler aufgetreten. 😪"),
          );
        }

        if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Es gibt keine Stundenplanänderungen. 😬"),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return TimetableChangeEntry(data: snapshot.data![index]);
          },
        );
      },
    );
  }
}
