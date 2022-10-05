import 'package:flutter/material.dart';
import 'package:stundenplan_app/constants.dart';

class DayDropdown extends StatefulWidget {
  final Function(int dayIndex) onDayChange;

  const DayDropdown({Key? key, required this.onDayChange}) : super(key: key);

  @override
  State<DayDropdown> createState() => _DayDropdownState();
}

class _DayDropdownState extends State<DayDropdown> {
  int? selectedDay = DateTime.now().weekday - 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedDay,
      items: Constants.days
          .asMap()
          .entries
          .map((MapEntry<int, String> entry) => DropdownMenuItem(
                value: entry.key,
                child: Text(entry.value),
              ))
          .toList(),
      onChanged: (int? dayIndex) {
        if (dayIndex == null) return;

        widget.onDayChange(dayIndex);

        setState(() {
          selectedDay = dayIndex;
        });
      },
    );
  }
}
