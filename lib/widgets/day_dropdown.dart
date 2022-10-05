import 'package:flutter/material.dart';

class DayDropdown extends StatefulWidget {
  final List<String> days = const [
    "Montag",
    "Dienstag",
    "Mittwoch",
    "Donnerstag",
    "Freitag",
  ];

  final Function(String day) onDayChange;

  const DayDropdown({Key? key, required this.onDayChange}) : super(key: key);

  @override
  State<DayDropdown> createState() => _DayDropdownState();
}

class _DayDropdownState extends State<DayDropdown> {
  String? selectedDay;

  @override
  void initState() {
    selectedDay = widget.days.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedDay,
      items: widget.days
          .map((String day) => DropdownMenuItem(
                value: day,
                child: Text(day),
              ))
          .toList(),
      onChanged: (String? day) {
        if (day == null) return;

        widget.onDayChange(day);

        setState(() {
          selectedDay = day;
        });
      },
    );
  }
}
