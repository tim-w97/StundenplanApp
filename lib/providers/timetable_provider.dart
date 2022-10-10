import 'package:flutter/foundation.dart';
import 'package:stundenplan_app/models/timetable_change_entry_data.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';
import 'package:stundenplan_app/services/crawler.dart';

class TimetableProvider with ChangeNotifier {
  bool timetableChangesAreVisible = false;

  int day = DateTime.now().weekday - 1;
  String course = "MC";

  late Future<List<TimetableEntryData>> timetableData;
  late Future<List<TimetableChangeEntryData>> timetableChangesData;

  Crawler crawler = Crawler();

  TimetableProvider() {
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
}