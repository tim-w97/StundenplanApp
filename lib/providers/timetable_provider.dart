import 'package:flutter/foundation.dart';
import 'package:stundenplan_app/models/timetable_change_entry_data.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';
import 'package:stundenplan_app/services/crawler.dart';

class TimetableProvider with ChangeNotifier {
  bool timetableChangesAreVisible = false;

  late int day;
  String course = "MC";

  late Future<List<TimetableEntryData>> timetableData;
  late Future<List<TimetableChangeEntryData>> timetableChangesData;

  Crawler crawler = Crawler();

  TimetableProvider() {
    day = _dayIndex;
    _setTimetable();
  }

  void changeDay({required int to}) {
    day = to;
    _setTimetable();
    notifyListeners();
  }

  void changeCourse({required String to}) {
    course = to;
    _setTimetable();
    notifyListeners();
  }

  void _setTimetable() {
    // fetch both timetable and timetable changes

    timetableData = crawler.fetchTimetable(
      courseKey: course,
      dayIndex: day,
    );

    timetableChangesData = crawler.fetchTimetableChanges(
      courseKey: course,
    );
  }

  void setTimetableChangesVisibilityTo(bool newValue) {
    timetableChangesAreVisible = newValue;
    notifyListeners();
  }

  int get _dayIndex {
    int weekday = DateTime.now().weekday;

    // if current day is weekend, set day to monday
    if (weekday > 5) weekday = 1;

    return weekday - 1;
  }
}
