import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:t1/model/job_model.dart';

class ScanApi {
  static Future<dynamic> scan(String code, String ic, String btn) async {
    final url = Uri.parse('https://wikicareer.com.my/api/attendance?att_syif_code=$code&ic_num=$ic&var=$btn');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final String msg = json.decode(response.body)["message"];
      return msg;
    } else {
      throw Exception();
    }
  }
}
