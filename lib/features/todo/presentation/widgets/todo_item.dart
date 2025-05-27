import 'package:flutter/material.dart';

import '../../domain/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(bool) onToggle;

  const TodoItem({super.key, required this.todo, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            todo.imageUrl.isNotEmpty
                ? Center(
                  child: AspectRatio(
                    aspectRatio: 1 / 1, // A square (1:1 ratio)
                    child: Image.network(
                      todo.imageUrl,
                      fit: BoxFit.cover, // Cover the entire area
                    ),
                  ),
                )
                : const SizedBox.shrink(),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(value: todo.isDone, onChanged: (value) {
                  onToggle(value ?? false);
                }),
                Text(
                  todo.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              todo.formattedDate,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            todo.description.isNotEmpty
                ? const SizedBox(height: 10)
                : const SizedBox.shrink(),
            todo.description.isNotEmpty
                ? Text(
                  todo.description,
                  maxLines: 2,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
