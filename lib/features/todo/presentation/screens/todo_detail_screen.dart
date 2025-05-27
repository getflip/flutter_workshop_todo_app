import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_workshop/features/todo/domain/models/todo_model.dart';

import '../cubits/todo_cubit.dart';

class TodoDetailScreen extends StatelessWidget {
  final String todoId;

  const TodoDetailScreen({super.key, required this.todoId});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        TodoModel? todo;
        try {
          todo = state is TodosLoaded ? state.todos.firstWhere((todo) => todo.id == todoId) : null;
        } catch (e) {
          todo = null;
        }

        if (todo != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Detail"),
              actions: [
                IconButton(
                  icon: Icon(
                    todo.isFavourite ? Icons.star : Icons.star_border,
                    color: todo.isFavourite ? Colors.amber : null,
                  ),
                  onPressed: () => todoCubit.toggleTodoFavourite(todo!.id),
                  tooltip: 'Favorite',
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child:
                        todo.imageUrl != null && todo.imageUrl!.isNotEmpty
                            ? Image.network(todo.imageUrl!, fit: BoxFit.cover)
                            : Image.asset('assets/placeholder.webp'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8,
                        children: [
                          Text(todo.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          todo.description != null && todo.description!.isNotEmpty
                              ? Text(todo.description!, style: const TextStyle(fontSize: 14))
                              : const SizedBox(),
                          Expanded(child: const SizedBox()),
                          Text(
                            todo.formattedDate,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('Todo Detail')),
            body: const Center(child: Text('Todo not found')),
          );
        }
      },
    );
  }
}
