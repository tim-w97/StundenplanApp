import 'package:flutter/material.dart';
import 'package:stundenplan_app/models/timetable_change_entry_data.dart';

class TimetableChangeEntry extends StatelessWidget {
  final TimetableChangeEntryData data;

  const TimetableChangeEntry({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                data.event,
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
              Text(data.missedDate),
              Text(data.newDate),
            ],
          ),
        ],
      ),
    );
  }
}
