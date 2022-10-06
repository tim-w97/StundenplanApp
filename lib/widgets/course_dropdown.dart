import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stundenplan_app/constants.dart';
import 'package:stundenplan_app/providers/timetable_provider.dart';

class CourseDropdown extends StatelessWidget {
  const CourseDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimetableProvider timetableProvider = context.watch<TimetableProvider>();

    return DropdownButton(
      value: timetableProvider.course,
      items: Constants.courses.keys
          .map((String courseKey) => DropdownMenuItem(
                value: courseKey,
                child: Text(Constants.courses[courseKey]!),
              ))
          .toList(),
      onChanged: (String? changedCourse) {
        if (changedCourse == null) return;

        timetableProvider.changeCourse(to: changedCourse);
      },
    );
  }
}
