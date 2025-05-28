import 'package:flutter/material.dart';

import '../../domain/models/todo_model.dart';

class TodoItemDetails extends StatelessWidget {
  final TodoModel todo;
  final bool isFavourited;
  final ValueChanged<bool?> onCheckboxChanged;
  final ValueChanged<bool> onFavouriteChanged;
  final VoidCallback? onDelete;

  const TodoItemDetails({
    super.key,
    required this.todo,
    required this.isFavourited,
    required this.onCheckboxChanged,
    required this.onFavouriteChanged,
    this.onDelete,
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
                IconButton(
                  icon: Icon(
                    isFavourited ? Icons.star : Icons.star_border,
                    color: isFavourited ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    onFavouriteChanged(!isFavourited);
                  },
                  tooltip: isFavourited ? 'Unfavourite' : 'Favourite',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                  tooltip: 'Delete',
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
