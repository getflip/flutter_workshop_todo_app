import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class is a stub for workshop participants to implement
@injectable
class TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  // ignore: unused_field
  final String _todoKey = 'todos';

  TodoLocalDataSource(this.sharedPreferences);

  /// Toggles the favourite status of a todo by its [id].
  /// Returns the new favourite status.
  Future<bool> toggleFavourite(String id) async {
    final favourites = sharedPreferences.getStringList('favourite_todos') ?? [];
    if (favourites.contains(id)) {
      favourites.remove(id);
      await sharedPreferences.setStringList('favourite_todos', favourites);
      return false;
    } else {
      favourites.add(id);
      await sharedPreferences.setStringList('favourite_todos', favourites);
      return true;
    }
  }

  /// Checks if a todo with [id] is favourited.
  bool isFavourite(String id) {
    final favourites = sharedPreferences.getStringList('favourite_todos') ?? [];
    return favourites.contains(id);
  }
}
