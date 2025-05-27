import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_dto.dart';

@injectable
class TodoRemoteDataSource {
  final http.Client _client;
  // TODO: Replace this with the URL we provide you
  final String baseUrl = 'https://683469d6464b49963602b8e8.mockapi.io';

  TodoRemoteDataSource(this._client);

  Future<List<TodoDTO>> getTodos() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/todo'));

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

  Future<TodoDTO> addTodo(String title, String description) async {
    try {
      final newTodo = {
        'title': title,
        'description': description,
        'createdAtSeconds': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      };

      log('Sending todo: ${json.encode(newTodo)}');

      final response = await _client.post(
        Uri.parse('$baseUrl/todo'),
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

  Future<TodoDTO> toggleTodoCompletion(String todoId, bool isDone) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/todo/$todoId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'isDone': isDone}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // If the API response is not in the expected format, transform it
        return TodoDTO.fromJson(responseData);
      } else {
        throw Exception('Failed to create todo: ${response.statusCode}');
      }
    } catch (e) {
      log('Error toggling todo completion: $e');
      throw Exception('Failed to toggle todo completion: $e');
    }
  }

  // For local client-side ID generation
  String generateId() {
    return const Uuid().v4();
  }
}
