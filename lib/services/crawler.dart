import 'dart:convert';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';

class Crawler {
  Future<List<TimetableEntryData>> fetchTimetable(
      {required String courseKey, required int dayIndex}) async {
    Document document = await getDocument(courseKey: courseKey);

    List<Element> dayTables = document.querySelectorAll(
        "body > div.twelve.columns.nop > div.hide-for-small > table");

    // remove the header table
    dayTables.removeAt(0);

    Element dayTable = dayTables.elementAt(dayIndex);

    List<Element> lectureRows = dayTable.querySelectorAll("tbody tr");

    List<TimetableEntryData> timetableEntries = lectureRows.map((Element row) {
      List<String> cellValues = row
          .querySelectorAll("td")
          .map((Element cell) => cell.text.trim())
          .toList();

      return TimetableEntryData(
          from: cellValues[1],
          to: cellValues[2],
          event: cellValues[3],
          professor: cellValues[4],
          type: cellValues[5],
          room: cellValues[6]);
    }).toList();

    return timetableEntries;
  }

  Future<Document> getDocument({required String courseKey}) async {
    String uriString = "https://www.hof-university.de/index.php"
        "?type=1421771406"
        "&id=79"
        "&tx_stundenplan_stundenplan[controller]=Ajax"
        "&tx_stundenplan_stundenplan[action]=loadVorlesungen"
        "&tx_stundenplan_stundenplan[studiengang]=$courseKey"
        "&tx_stundenplan_stundenplan[semester]=3_WS_2022"
        "&tx_stundenplan_stundenplan[view]=alle"
        "&1664909491132";

    Uri uri = Uri.parse(uriString);

    Response response = await get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        "Error while fetching the timetable (status code ${response.statusCode}).",
      );
    }

    dynamic jsonData = await jsonDecode(response.body);
    String html = await jsonData["vorlesungen"];

    Document document = parse(html);

    return document;
  }
}
