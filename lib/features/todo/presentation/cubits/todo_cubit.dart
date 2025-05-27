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

  Future<void> updateDone(String id, bool isDone, List<TodoModel> todos) async {
    try {
      final updatedTodos =
          todos
              .map(
                (todo) => todo.id == id ? todo.copyWith(isDone: isDone) : todo,
              )
              .toList();
      emit(TodosLoaded(todos: updatedTodos));
      await _repository.updateTodo(id, isDone);
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }
}
