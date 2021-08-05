import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:t1/model/shift_model.dart';

class ShiftApi {
  static Future<List<Shift>> getShift(String query) async {
    final url = Uri.parse('https://wikicareer.com.my/api/list_syif/LJClYbXM');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List shift = json.decode(response.body)["syif"];

      return shift.map((json) => Shift.fromJson(json)).where((shift) {
        final titleLower = shift.attendance_syifs_job_code.toLowerCase();

        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
