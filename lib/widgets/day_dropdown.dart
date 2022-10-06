import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stundenplan_app/constants.dart';
import 'package:stundenplan_app/providers/timetable_provider.dart';

class DayDropdown extends StatelessWidget {
  const DayDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimetableProvider timetableProvider = context.watch<TimetableProvider>();

    return DropdownButton<int>(
      value: timetableProvider.day,
      items: Constants.days
          .asMap()
          .entries
          .map((MapEntry<int, String> entry) => DropdownMenuItem(
                value: entry.key,
                child: Text(entry.value),
              ))
          .toList(),
      onChanged: (int? changedDay) {
        if (changedDay == null) return;

        timetableProvider.changeDay(to: changedDay);
      },
    );
  }
}
