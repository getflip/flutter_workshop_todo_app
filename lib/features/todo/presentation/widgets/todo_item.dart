import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_workshop/features/todo/presentation/cubits/todo_cubit.dart';

import '../../domain/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final bool hasImage = todo.imageUrl != null && todo.imageUrl!.isNotEmpty;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          todoCubit.updateStatus(todo.id, !todo.isDone);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 4,
                children: [
                  todo.isDone
                      ? Icon(
                        Icons.check_box_outlined,
                        color: Colors.green,
                        size: 24.0,
                        semanticLabel: 'Status: Done',
                      )
                      : const Icon(
                        Icons.check_box_outline_blank,
                        size: 24.0,
                        semanticLabel: 'Status: To do',
                      ),
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                todo.description ?? '<no description>',
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              hasImage
                  ? Image.network(
                    todo.imageUrl!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                  : const SizedBox.shrink(),
              const SizedBox(height: 4),
              Text(
                todo.formattedDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
