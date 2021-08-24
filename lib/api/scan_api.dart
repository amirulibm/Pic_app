import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:t1/model/job_model.dart';

class ScanApi {
  static Future<dynamic> scan(String code, String ic, String btn) async {
    final url = Uri.parse(
        'https://wikicareer.com.my/api/attendance?att_syif_code=$code&ic_num=$ic&var=$btn');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final ScanResponse res =
          ScanResponse.fromJson(json.decode(response.body));
      return res;
    } else {
      throw Exception();
    }
  }
}

class ScanResponse {
  String name;
  String ic;
  String status;

  ScanResponse({this.name, this.ic, this.status});

  factory ScanResponse.fromJson(Map<String, dynamic> jsonData) {
    return ScanResponse(
      name: jsonData['name'],
      ic: jsonData['ic'],
      status: jsonData['status'],
    );
  }
}
