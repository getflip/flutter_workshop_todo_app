import 'package:flutter/material.dart';

import '../../domain/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onViewDetails;
  final bool isFavourited;
  final ValueChanged<bool> onFavouriteChanged;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onCheckboxChanged,
    required this.onViewDetails,
    required this.isFavourited,
    required this.onFavouriteChanged,
  });

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
            Row(
              children: [
                Checkbox(
                  value: todo.isDone,
                  onChanged: (_) {
                    onCheckboxChanged(!todo.isDone);
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onViewDetails,
                    child: Text(
                      todo.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
              ],
            ),
            GestureDetector(
              onTap: onViewDetails,
              behavior: HitTestBehavior.translucent,
              child: Column(
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
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  if (todo.imageUrl.isNotEmpty)
                    Image.network(
                      todo.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
