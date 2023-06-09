import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/suggestion.dart';
// import 'package:avicola/flutter_riverpod.dart';
// import 'package:riverpod_explorer/ui/models/suggestion.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  Future<Suggestion> getSuggestion(String id) async {
    try {
      final res = await Dio().get('http://localhost:5000');
      print(res);
      return Suggestion.fromJson(res.data);
    } catch (e) {
      throw Exception('Error getting suggestion');
    }
  }
}
