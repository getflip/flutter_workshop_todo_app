import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/todo_model.dart';
import '../datasources/todo_remote_datasource.dart';
import '../models/todo_dto.dart';

@injectable
class TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepository(this.remoteDataSource);

  // Get todos from remote data source only
  Future<List<TodoModel>> getTodos() async {
    try {
      // Get todos from the API
      final remoteDtos = await remoteDataSource.getTodos();

      // Map DTOs to domain models
      final todos = remoteDtos.map(_mapDtoToModel).toList();

      // Sort todos by creation date (newest first)
      todos.sort((a, b) => b.effectiveCreatedAt.compareTo(a.effectiveCreatedAt));

      return todos;
    } catch (e) {
      log('Error fetching remote todos: $e');
      // Return empty list on error
      return [];
    }
  }

  // Add a new todo remotely
  Future<void> addTodo(String title, String description, String imageUrl) async {
    try {
      // Add todo remotely
      await remoteDataSource.addTodo(title, description, imageUrl);
    } catch (e) {
      log('Error adding remote todo: $e');
    }
  }

  Future<TodoModel> updateDoneState(String id, bool isDone) async {
    try {
      return _mapDtoToModel(await remoteDataSource.updateDoneState(id, isDone));
    } catch (e) {
      log('Error updating done state: $e');
      throw Exception('Error updating done state');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await remoteDataSource.deleteTodo(id);
    } catch (e) {
      log('Error while deleting the todo: $e');
    }
  }

  // Helper method to map DTOs to domain models
  TodoModel _mapDtoToModel(TodoDTO dto) {
    try {
      DateTime? createdAt;
      if (dto.createdAtSeconds != null) {
        createdAt = DateTime.fromMillisecondsSinceEpoch(dto.createdAtSeconds! * 1000);
      }

      return TodoModel(id: dto.id, title: dto.title, createdAt: createdAt, isDone: dto.isDone, imageUrl: dto.imageUrl, description: dto.description);
    } catch (e) {
      log('Error mapping DTO to model: $e');
      return TodoModel(id: const Uuid().v4(), title: 'Unknown title', createdAt: DateTime.now(), isDone: false, imageUrl: '', description: '');
    }
  }
}
