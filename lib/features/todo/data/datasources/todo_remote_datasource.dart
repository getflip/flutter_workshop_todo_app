import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

import '../models/todo_dto.dart';

@injectable
class TodoRemoteDataSource {
  final http.Client _client;
  final String baseUrl = 'https://6835745dcd78db2058c1928b.mockapi.io';

  TodoRemoteDataSource(this._client);

  Future<List<TodoDTO>> getTodos() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/todo'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        log('API Response: ${response.body}');
        return jsonList.map((json) => TodoDTO.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos: ${response.statusCode} \n ${response.body}');
      }
    } catch (e) {
      log('Error fetching todos: $e');
      throw Exception('Failed to load todos: $e');
    }
  }

  Future<TodoDTO> addTodo(String title, String description, String imageUrl) async {
    try {
      final newTodo = {
        'id': generateId(),
        'title': title,
        'createdAtSeconds': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'isDone': false,
        'imageUrl': imageUrl,
        'description': description,
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
        throw Exception('Failed to create todo: ${response.statusCode} \n ${response.body}');
      }
    } catch (e) {
      log('Error adding todo: $e');
      throw Exception('Failed to create todo: $e');
    }
  }

  Future<TodoDTO> updateDoneState(String id, bool isDone) async {
    try {
      log('Updating done in a todo with id: $id');

      final response = await _client.patch(
        Uri.parse('$baseUrl/todo/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'isDone': isDone}),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // If the API response is not in the expected format, transform it
        return TodoDTO.fromJson(responseData);
      } else {
        throw Exception('Failed to create todo: ${response.statusCode} \n ${response.body}');
      }
    } catch (e) {
      log('error while updating done state: $e');
      throw Exception('Failed to update done state');
    }
  }

  // For local client-side ID generation
  String generateId() {
    return const Uuid().v4();
  }
}
