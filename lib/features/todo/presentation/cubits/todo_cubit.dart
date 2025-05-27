import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/todo_repository.dart';
import '../../domain/models/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _repository;

  TodoCubit(this._repository) : super(TodosLoading());

  Future<void> loadTodos() async {
    try {
      emit(TodosLoading());
      final todos = await _repository.getTodos();
      final favouriteIds = await _repository.getFavouriteIds();

      emit(TodosLoaded(todos: todos, favouriteIds: favouriteIds));
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

  Future<void> toggleTodo(String id, bool isDone) async {
    try {
      // Optimistic update - update UI immediately
      if (state is TodosLoaded) {
        final currentTodos = (state as TodosLoaded).todos;
        final favouriteTodos = (state as TodosLoaded).favouriteIds;
        final updatedTodos = currentTodos.map((todo) {
          if (todo.id == id) {
            return todo.copyWith(isDone: isDone);
          }
          return todo;
        }).toList();
        emit(TodosLoaded(todos: updatedTodos, favouriteIds: favouriteTodos));
      }

      // Make API call
      await _repository.updateTodo(id, isDone);

      // Refresh from server to ensure consistency
      await loadTodos();
    } catch (e) {
      // Revert optimistic update on error
      await loadTodos();
      emit(TodosError(message: e.toString()));
    }
  }

  Future<void> toggleFavourite(String todoId) async {
    final currentState = state;
    if (currentState is! TodosLoaded) return;

    try {
      final newFavouriteIds = Set<String>.from(currentState.favouriteIds);
      if (newFavouriteIds.contains(todoId)) {
        newFavouriteIds.remove(todoId);
        await _repository.removeFavourite(todoId);
      } else {
        newFavouriteIds.add(todoId);
        await _repository.addFavourite(todoId);
      }

      emit(TodosLoaded(todos: currentState.todos, favouriteIds: newFavouriteIds));
    } catch (e) {
      emit(TodosError(message: 'Failed to update favourite: $e'));
      loadTodos();
    }
  }

  bool isFavourite(String todoId) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      return currentState.favouriteIds.contains(todoId);
    }
    return false;
  }
}
