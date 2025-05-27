import 'package:flutter/material.dart';

import '../../domain/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          spacing: 8,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child:
                  todo.imageUrl != null && todo.imageUrl!.isNotEmpty
                      ? Image.network(todo.imageUrl!, fit: BoxFit.cover)
                      : Image.asset('assets/placeholder.webp'),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  todo.description != null && todo.description!.isNotEmpty
                      ? Text(
                        todo.description!,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                      : const SizedBox(),

                  const SizedBox(height: 4),
                  Text(
                    todo.formattedDate,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
