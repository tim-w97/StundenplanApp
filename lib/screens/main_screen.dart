import 'package:flutter/material.dart';
import 'package:stundenplan_app/constants.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';
import 'package:stundenplan_app/services/crawler.dart';
import 'package:stundenplan_app/widgets/course_dropdown.dart';
import 'package:stundenplan_app/widgets/day_dropdown.dart';
import 'package:stundenplan_app/widgets/timetable.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<TimetableEntryData>> timetableData;

  String lastSelectedCourseKey = Constants.courses.keys.first;
  int lastSelectedDay = 0;

  Crawler crawler = Crawler();

  void changeCourse(String courseKey) {
    lastSelectedCourseKey = courseKey;

    setState(() {
      timetableData = crawler.fetchTimetable(
        courseKey: courseKey,
        dayIndex: lastSelectedDay,
      );
    });
  }

  void changeDay(int dayIndex) {
    lastSelectedDay = dayIndex;

    setState(() {
      timetableData = crawler.fetchTimetable(
        courseKey: lastSelectedCourseKey,
        dayIndex: dayIndex,
      );
    });
  }

  @override
  void initState() {
    timetableData = crawler.fetchTimetable(
      courseKey: Constants.courses.keys.first,
      dayIndex: DateTime.now().weekday - 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CourseDropdown(onCourseChange: changeCourse),
                  const SizedBox(width: 10),
                  DayDropdown(onDayChange: changeDay),
                ],
              ),
              Row(
                children: const [
                  Switch(value: false, onChanged: null),
                  Text("Stundenplanänderungen"),
                ],
              ),
              Expanded(
                child: Timetable(data: timetableData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
