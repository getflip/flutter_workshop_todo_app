import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/todo_model.dart';
import '../datasources/todo_remote_datasource.dart';
import '../models/todo_dto.dart';

@injectable
class TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  static const String _favouritePrefix = 'favourite_';
  static const String _favouritesList = 'favourites_list';

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
  Future<void> addTodo(String title, String? description, String? imageUrl) async {
    try {
      // Add todo remotely
      await remoteDataSource.addTodo(title, description, imageUrl);
    } catch (e) {
      log('Error adding remote todo: $e');
    }
  }

  Future<void> updateTodo(String id, bool isDone) async {
    try {
      await remoteDataSource.updateTodo(id, isDone);
    } catch (e) {
      log('update todo [id:$id] [isDone:$isDone], : $e');
    }
  }

  Future<Set<String>> getFavouriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favouritesList = prefs.getStringList(_favouritesList) ?? [];
    return Set<String>.from(favouritesList);
  }

  Future<void> addFavourite(String todoId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_favouritePrefix$todoId', true);

    final favouritesList = prefs.getStringList(_favouritesList) ?? [];
    if (!favouritesList.contains(todoId)) {
      favouritesList.add(todoId);
      await prefs.setStringList(_favouritesList, favouritesList);
    }
  }

  Future<void> removeFavourite(String todoId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_favouritePrefix$todoId');

    final favouritesList = prefs.getStringList(_favouritesList) ?? [];
    favouritesList.remove(todoId);
    await prefs.setStringList(_favouritesList, favouritesList);
  }

  Future<bool> isFavourite(String todoId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_favouritePrefix$todoId') ?? false;
  }

  // Helper method to map DTOs to domain models
  TodoModel _mapDtoToModel(TodoDTO dto) {
    try {
      DateTime? createdAt;
      if (dto.createdAtSeconds != null) {
        createdAt = DateTime.fromMillisecondsSinceEpoch(dto.createdAtSeconds! * 1000);
      }

      return TodoModel(id: dto.id, title: dto.title, isDone: dto.isDone, description: dto.description, imageUrl: dto.imageUrl, createdAt: createdAt);
    } catch (e) {
      log('Error mapping DTO to model: $e');
      return TodoModel(id: const Uuid().v4(), title: 'Unknown title', isDone: false, createdAt: DateTime.now());
    }
  }
}
