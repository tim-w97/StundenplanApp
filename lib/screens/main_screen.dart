import 'package:flutter/material.dart';
import 'package:stundenplan_app/constants.dart';
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
  late Future<String> timetableData;

  Crawler crawler = Crawler();

  void changeCourse(String courseKey) {
    setState(() {
      timetableData = crawler.fetchTimetable(courseKey: courseKey);
    });
  }

  void changeDay(String day) {}

  @override
  void initState() {
    timetableData =
        crawler.fetchTimetable(courseKey: Constants.courses.keys.first);
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
                children: [
                  Switch(value: false, onChanged: (bool? newValue) {}),
                  const Text("Stundenplanänderungen"),
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
