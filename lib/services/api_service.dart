import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity_log.dart';
import '../config/api_config.dart';

class ApiService {
  Future<List<ActivityLog>> getActivityLogs(String username) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/activity-logs?username=$username'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ActivityLog> logs = body
          .map((dynamic item) => ActivityLog.fromJson(item))
          .toList();
      return logs;
    } else {
      throw Exception('Failed to load activity logs: ${response.statusCode}');
    }
  }
}
