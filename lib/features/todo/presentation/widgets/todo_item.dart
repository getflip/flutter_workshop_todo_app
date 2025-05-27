import 'package:flutter/material.dart';

import '../../domain/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final ValueChanged<bool>? onToggle;

  const TodoItem({super.key, required this.todo, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              clipBehavior: Clip.antiAlias,
              child: todo.imageUrl != null && todo.imageUrl!.isNotEmpty
                  ? Image.network(
                todo.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[600],
                    size: 30,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                    ),
                  );
                },
              )
                  : Icon(
                Icons.image,
                color: Colors.grey[600],
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (todo.description != null && todo.description!.isNotEmpty) ...[
                    Text(
                      todo.description!,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                  ],
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
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: todo.isDone,
                  onChanged: onToggle,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green.withValues(alpha: 0.3)
                ),
                Text(
                  todo.isDone == true ? 'Done' : 'Todo',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}