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
      todos.sort(
        (a, b) => b.effectiveCreatedAt.compareTo(a.effectiveCreatedAt),
      );

      return todos;
    } catch (e) {
      log('Error fetching remote todos: $e');
      // Return empty list on error
      return [];
    }
  }

  // Add a new todo remotely
  Future<void> addTodo(String title, String description) async {
    try {
      // Add todo remotely
      await remoteDataSource.addTodo(title, description);
    } catch (e) {
      log('Error adding remote todo: $e');
    }
  }

  // Toggle the completion status of a todo
  Future<void> toggleTodoCompletion(String todoId, bool isDone) async {
    try {
      // Toggle completion status remotely
      log('Toggling todo completion: $todoId, isDone: $isDone');
      await remoteDataSource.toggleTodoCompletion(todoId, isDone);
    } catch (e) {
      log('Error toggling todo completion: $e');
    }
  }

  // Helper method to map DTOs to domain models
  TodoModel _mapDtoToModel(TodoDTO dto) {
    try {
      DateTime? createdAt;
      if (dto.createdAtSeconds != null) {
        createdAt = DateTime.fromMillisecondsSinceEpoch(
          dto.createdAtSeconds! * 1000,
        );
      }

      return TodoModel(
        id: dto.id,
        title: dto.title,
        description: dto.description,
        imageUrl: dto.imageUrl,
        isDone: dto.isDone,
        createdAt: createdAt,
      );
    } catch (e) {
      log('Error mapping DTO to model: $e');
      return TodoModel(
        id: const Uuid().v4(),
        title: 'Unknown title',
        description: 'Unknown description',
        imageUrl: 'no image',
        isDone: false,
        createdAt: DateTime.now(),
      );
    }
  }
}
