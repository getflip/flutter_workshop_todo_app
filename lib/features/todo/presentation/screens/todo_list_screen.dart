import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/todo_cubit.dart';
import '../widgets/todo_item.dart';
import 'todo_form_screen.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get a reference to the TodoCubit
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodosLoaded) {
            final todos = state.todos;

            if (todos.isEmpty) {
              return const Center(
                child: Text(
                  'No todos yet!\nTap the + button to add one.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoItem(todo: todos[index], onToggle: (isDone) {
                  todoCubit.updateDone(todos[index].id, isDone);
                });
              },
            );
          } else if (state is TodosError) {
            return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(value: todoCubit, child: const TodoFormScreen()),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
