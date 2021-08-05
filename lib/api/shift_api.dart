import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:t1/model/shift_model.dart';

class ShiftApi {
  static Future<List<Shift>> getShift(String jobCode) async {
    final url = Uri.parse('https://wikicareer.com.my/api/list_syif/$jobCode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> shift = json.decode(response.body)["syif"];
      List<Shift> shifted = [];
      shift.forEach((element) {
        shifted.add(Shift.fromJson(element));
      });

      return shifted;
    } else {
      throw Exception();
    }
  }
}
