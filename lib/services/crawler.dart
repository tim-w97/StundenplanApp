import 'dart:convert';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:stundenplan_app/models/timetable_change_entry_data.dart';
import 'package:stundenplan_app/models/timetable_entry_data.dart';

class Crawler {
  Future<List<TimetableChangeEntryData>> fetchTimetableChanges(
      {required String courseKey}) async {
    Document document =
        await getDocumentForTimetableChanges(courseKey: courseKey);

    List<Element> tableRows = document.querySelectorAll(
        "body > div > div.hide-for-small > table > tbody > tr");

    if (tableRows.isEmpty) return List.empty();

    List<TimetableChangeEntryData> timetableChangesEntries =
        tableRows.map((Element row) {
      List<Element> cells = row.querySelectorAll("td");

      List<String> cellValues =
          cells.map((Element cell) => cell.text.trim()).toList();

      return TimetableChangeEntryData(
        event: cellValues[1],
        professor: cellValues[2],
        missedDate: cellValues[3].replaceAll(" ", ""),
        newDate: cellValues[4].replaceAll(" ", ""),
      );
    }).toList();

    return timetableChangesEntries;
  }

  Future<List<TimetableEntryData>> fetchTimetable(
      {required String courseKey, required int dayIndex}) async {
    Document document = await getDocumentForTimetable(courseKey: courseKey);

    List<Element> dayTables = document.querySelectorAll(
        "body > div.twelve.columns.nop > div.hide-for-small > table");

    // remove the header table
    dayTables.removeAt(0);

    if (dayIndex >= dayTables.length) {
      return List.empty();
    }

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

  Future<Document> getDocumentForTimetableChanges(
      {required String courseKey}) async {
    String uri = "https://www.hof-university.de/index.php"
        "?type=1421771406"
        "&id=166"
        "&tx_stundenplan_stundenplan[controller]=Ajax"
        "&tx_stundenplan_stundenplan[action]=loadAenderungen"
        "&tx_stundenplan_stundenplan[studiengang]=$courseKey"
        "&tx_stundenplan_stundenplan[semester]=3%23WS%232022"
        "&tx_stundenplan_stundenplan[datum]=TT.MM.JJJJ"
        "&1665419926704";

    return _getDocumentFor(uri: uri);
  }

  Future<Document> getDocumentForTimetable({required String courseKey}) async {
    String uri = "https://www.hof-university.de/index.php"
        "?type=1421771406"
        "&id=79"
        "&tx_stundenplan_stundenplan[controller]=Ajax"
        "&tx_stundenplan_stundenplan[action]=loadVorlesungen"
        "&tx_stundenplan_stundenplan[studiengang]=$courseKey"
        "&tx_stundenplan_stundenplan[semester]=3_WS_2022"
        "&tx_stundenplan_stundenplan[view]=alle"
        "&1664909491132";

    return _getDocumentFor(uri: uri);
  }

  Future<Document> _getDocumentFor({required String uri}) async {
    Uri parsedUri = Uri.parse(uri);

    Response response = await get(parsedUri);

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
