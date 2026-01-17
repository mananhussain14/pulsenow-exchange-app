import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static const String baseUrl = AppConstants.baseUrl;

  Future<List<Map<String, dynamic>>> getMarketData() async {
    final uri = Uri.parse('$baseUrl/market-data');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load market data');
    }

    final decoded = json.decode(response.body);

    if (decoded is Map && decoded['data'] is List) {
      return List<Map<String, dynamic>>.from(decoded['data']);
    }

    if (decoded is List) {
      return List<Map<String, dynamic>>.from(decoded);
    }

    return [];
  }
}
