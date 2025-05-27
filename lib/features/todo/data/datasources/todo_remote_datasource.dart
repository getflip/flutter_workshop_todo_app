import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_dto.dart';

@injectable
class TodoRemoteDataSource {
  final http.Client _client;
  final String baseUrl = 'https://6835753ccd78db2058c196b3.mockapi.io/';

  TodoRemoteDataSource(this._client);

  Future<List<TodoDTO>> getTodos() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/todos'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        log('API Response: ${response.body}');
        return jsonList.map((json) => TodoDTO.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching todos: $e');
      throw Exception('Failed to load todos: $e');
    }
  }

  Future<TodoDTO> addTodo(String title) async {
    try {
      final newTodo = {'title': title, 'createdAtSeconds': DateTime.now().millisecondsSinceEpoch ~/ 1000};

      log('Sending todo: ${json.encode(newTodo)}');

      final response = await _client.post(
        Uri.parse('$baseUrl/todos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newTodo),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // If the API response is not in the expected format, transform it
        return TodoDTO.fromJson(responseData);
      } else {
        throw Exception('Failed to create todo: ${response.statusCode}');
      }
    } catch (e) {
      log('Error adding todo: $e');
      throw Exception('Failed to create todo: $e');
    }
  }

  // For local client-side ID generation
  String generateId() {
    return const Uuid().v4();
  }
}
