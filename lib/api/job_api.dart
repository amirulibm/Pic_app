import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:t1/model/job_model.dart';

class Jobapi {
  static Future<List<Job>> getBooks(String query) async {
    final url = Uri.parse('https://wikicareer.com.my/api/list_jobs');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jobs = json.decode(response.body)["job"];

      return jobs.map((json) => Job.fromJson(json)).where((book) {
        final titleLower = book.job_events_name.toLowerCase();

        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
