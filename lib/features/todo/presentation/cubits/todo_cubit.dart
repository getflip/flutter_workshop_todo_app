import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/todo_repository.dart';
import '../../domain/models/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _repository;

  TodosLoaded get loaded => state as TodosLoaded;

  TodoCubit(this._repository) : super(TodosLoading());

  Future<void> loadTodos() async {
    try {
      emit(TodosLoading());
      final todos = await _repository.getTodos();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }

  Future<void> addTodo(String title, String? description, String? imageUrl) async {
    try {
      emit(TodosLoading());
      await _repository.addTodo(title, description, imageUrl);
      await loadTodos();
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }

  Future<void> updateTodoStatus(String id, bool isDone) async {
    try {
      final updatedTodo = await _repository.updateTodoStatus(id, isDone);

      if (updatedTodo != null) {
        emit(TodosLoaded(todos: loaded.todos.map((todo) => todo.id == id ? updatedTodo : todo).toList()));
      }
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }

  Future<void> toggleTodoFavourite(String id) async {
    try {
      TodoModel? currentTodo = loaded.todos.firstWhere((todo) => todo.id == id);

      final updatedFavorite = await _repository.toggleTodoFavourite(id);

      if (updatedFavorite == null) return;

      TodoModel updatedTodo = currentTodo.copyWith(isFavourite: updatedFavorite);

      emit(TodosLoaded(todos: loaded.todos.map((todo) => todo.id == id ? updatedTodo : todo).toList()));
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }
}
