import 'package:flutter/material.dart';

class DayDropdown extends StatefulWidget {
  const DayDropdown({Key? key}) : super(key: key);

  @override
  State<DayDropdown> createState() => _DayDropdownState();
}

class _DayDropdownState extends State<DayDropdown> {
  List<String> days = [
    "Montag",
    "Dienstag",
    "Mittwoch",
    "Donnerstag",
    "Freitag",
  ];

  String? selectedDay;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedDay,
      items: days
          .map((String day) => DropdownMenuItem(
                value: day,
                child: Text(day),
              ))
          .toList(),
      onChanged: (String? day) {
        setState(() {
          selectedDay = day;
        });
      },
    );
  }
}
