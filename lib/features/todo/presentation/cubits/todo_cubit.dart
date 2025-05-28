import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/todo_repository.dart';
import '../../domain/models/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _repository;

  TodoCubit(this._repository) : super(TodosLoading());

  Future<Set<String>> _getFavouritedIds() async {
    final todos = await _repository.getTodos();
    final ids = <String>{};
    for (final todo in todos) {
      if (await _repository.isTodoFavourited(todo.id)) {
        ids.add(todo.id);
      }
    }
    return ids;
  }

  Future<void> loadTodos() async {
    try {
      emit(TodosLoading());
      final todos = await _repository.getTodos();
      final favouritedIds = await _getFavouritedIds();
      emit(TodosLoaded(todos: todos, favouritedIds: favouritedIds));
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }

  Future<void> addTodo(String title, String description) async {
    try {
      emit(TodosLoading());
      await _repository.addTodo(title, description);
      await loadTodos();
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }

  Future<void> toggleTodoCompletion(String todoId, bool isDone) async {
    try {
      await _repository.toggleTodoCompletion(todoId, isDone);
      await loadTodos();
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }

  Future<void> toggleTodoFavourite(String todoId, bool isFavourited) async {
    try {
      await _repository.toggleTodoFavourite(todoId, isFavourited);
      await loadTodos();
    } catch (e) {
      emit(TodosError(message: e.toString()));
    }
  }
}
