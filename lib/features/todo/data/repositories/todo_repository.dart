import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/todo_model.dart';
import '../datasources/todo_local_datasource.dart';
import '../datasources/todo_remote_datasource.dart';
import '../models/todo_dto.dart';

@injectable
class TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;

  TodoRepository(this.remoteDataSource, this.localDataSource);

  // Get todos from remote data source only
  Future<List<TodoModel>> getTodos() async {
    try {
      // Get todos from the API
      final remoteDtos = await remoteDataSource.getTodos();
      final favouriteIds = await localDataSource.getFavouriteTodos();

      // Map DTOs to domain models
      final todos = remoteDtos.map((dto) => _mapDtoToModel(dto, favouriteIds)).toList();

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
  Future<void> addTodo(String title, String? description, String? imageUrl) async {
    try {
      // Add todo remotely
      await remoteDataSource.addTodo(title, description, imageUrl);
    } catch (e) {
      log('Error adding remote todo: $e');
    }
  }

  Future<TodoModel?> updateTodoStatus(String id, bool isDone) async {
    try {
      // Update todo status remotely
      final favouriteIds = await localDataSource.getFavouriteTodos();

      return _mapDtoToModel(await remoteDataSource.updateTodoStatus(id, isDone), favouriteIds);
    } catch (e) {
      log('Error updating remote todo status: $e');
      return null;
    }
  }

  Future<bool?> toggleTodoFavourite(String id) async {
    try {
      final favouriteIds = await localDataSource.getFavouriteTodos();

      final isFavourite = favouriteIds.contains(id);

      if (isFavourite) {
        favouriteIds.remove(id);
      } else {
        favouriteIds.add(id);
      }

      await localDataSource.setFavouriteTodos(favouriteIds);

      return !isFavourite;
    } catch (e) {
      log('Error toggling todo favourite: $e');
      return null;
    }
  }

  // Helper method to map DTOs to domain models
  TodoModel _mapDtoToModel(TodoDTO dto, List<String> favouriteIds) {
    try {
      DateTime? createdAt;
      if (dto.createdAtSeconds != null) {
        createdAt = DateTime.fromMillisecondsSinceEpoch(dto.createdAtSeconds! * 1000);
      }
      final isFavourite = favouriteIds.contains(dto.id);

      return TodoModel(
        id: dto.id,
        title: dto.title,
        description: dto.description,
        imageUrl: dto.imageUrl,
        isDone: dto.isDone,
        isFavourite: isFavourite,
        createdAt: createdAt,
      );
    } catch (e) {
      log('Error mapping DTO to model: $e');
      return TodoModel(id: const Uuid().v4(), title: 'Unknown title', isFavourite: false, createdAt: DateTime.now());
    }
  }
}
