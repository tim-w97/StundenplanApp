import 'package:flutter/material.dart';
import 'package:stundenplan_app/constants.dart';

class CourseDropdown extends StatefulWidget {
  final Function(String course) onCourseChange;

  const CourseDropdown({Key? key, required this.onCourseChange})
      : super(key: key);

  @override
  State<CourseDropdown> createState() => _CourseDropdownState();
}

class _CourseDropdownState extends State<CourseDropdown> {
  String? selectedCourseKey;

  @override
  void initState() {
    selectedCourseKey = Constants.courses.keys.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCourseKey,
      items: Constants.courses.keys
          .map((String courseKey) => DropdownMenuItem(
                value: courseKey,
                child: Text(Constants.courses[courseKey]!),
              ))
          .toList(),
      onChanged: (String? courseKey) {
        if (courseKey == null) return;

        widget.onCourseChange(courseKey);

        setState(() {
          selectedCourseKey = courseKey;
        });
      },
    );
  }
}
