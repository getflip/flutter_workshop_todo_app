part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodosLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<TodoModel> todos;
  final Set<String> favouriteIds;

  const TodosLoaded({
    required this.todos,
    required this.favouriteIds,
  });

  @override
  List<Object> get props => [todos, favouriteIds];
}

class TodosError extends TodoState {
  final String message;

  const TodosError({required this.message});

  @override
  List<Object> get props => [message];
}
