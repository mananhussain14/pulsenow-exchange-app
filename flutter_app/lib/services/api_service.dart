import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/market_data_model.dart';
import '../utils/constants.dart';

class ApiService {
  static const String baseUrl = AppConstants.baseUrl;

  Future<List<MarketData>> getMarketData() async {
    try {
      final uri = Uri.parse('$baseUrl${AppConstants.marketDataEndpoint}');

      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('Server error: ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body);

      // Expected: { "success": true, "data": [ ... ] }
      if (decoded is Map<String, dynamic> && decoded['data'] is List) {
        final list = List<Map<String, dynamic>>.from(decoded['data'] as List);
        return list.map(MarketData.fromJson).toList();
      }

      // Fallback: [ ... ]
      if (decoded is List) {
        final list = List<Map<String, dynamic>>.from(decoded);
        return list.map(MarketData.fromJson).toList();
      }

      throw Exception('Unexpected response format');
    } on SocketException {
      throw Exception('No internet connection / backend not reachable.');
    } on HttpException {
      throw Exception('HTTP error while fetching market data.');
    } on FormatException {
      throw Exception('Bad response format from server.');
    } catch (e) {
      throw Exception('Failed to load market data: $e');
    }
  }
}
