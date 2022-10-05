import 'package:flutter/material.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';

class TimetableEntry extends StatelessWidget {
  final TimetableEntryData data;

  const TimetableEntry({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "${data.event} (${data.type})",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
          const Divider(),
          Text(data.professor),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("von ${data.from} bis ${data.to} Uhr"),
              Text(data.room),
            ],
          ),
        ],
      ),
    );
  }
}
