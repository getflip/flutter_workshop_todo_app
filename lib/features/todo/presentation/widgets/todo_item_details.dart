import 'package:flutter/material.dart';

import '../../domain/models/todo_model.dart';

class TodoItemDetails extends StatelessWidget {
  final TodoModel todo;
  final ValueChanged<bool?> onCheckboxChanged;

  const TodoItemDetails({
    super.key,
    required this.todo,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: todo.isDone,
                  onChanged: (_) {
                    onCheckboxChanged(!todo.isDone);
                  },
                ),
                Expanded(
                  child: Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  todo.formattedDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  todo.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                if (todo.imageUrl.isNotEmpty)
                  Image.network(todo.imageUrl, fit: BoxFit.fitWidth),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
