import 'dart:convert';

import 'package:http/http.dart';

class Crawler {
  Future<String> fetchTimetable({required String courseKey}) async {
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

    return html;
  }
}
