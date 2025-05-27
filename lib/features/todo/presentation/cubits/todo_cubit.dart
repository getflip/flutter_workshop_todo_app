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

  Future<void> toggleTodo(String id, bool isDone) async {
    try {
      // Optimistic update - update UI immediately
      if (state is TodosLoaded) {
        final currentTodos = (state as TodosLoaded).todos;
        final updatedTodos = currentTodos.map((todo) {
          if (todo.id == id) {
            return todo.copyWith(isDone: isDone);
          }
          return todo;
        }).toList();
        emit(TodosLoaded(todos: updatedTodos));
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
}
