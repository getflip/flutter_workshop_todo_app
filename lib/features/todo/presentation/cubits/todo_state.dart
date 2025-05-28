part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodosLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<TodoModel> todos;
  final Set<String> favouritedIds;

  const TodosLoaded({required this.todos, required this.favouritedIds});

  @override
  List<Object> get props => [todos, favouritedIds];
}

class TodosError extends TodoState {
  final String message;

  const TodosError({required this.message});

  @override
  List<Object> get props => [message];
}
