import 'dart:developer';

import 'package:flutter/material.dart';

import '../../domain/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final bool hasImage = todo.imageUrl != null && todo.imageUrl!.isNotEmpty;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }
}
