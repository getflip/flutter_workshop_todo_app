import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String _todoFavouriteKey = 'favourite_todos';

  TodoLocalDataSource(this.sharedPreferences);

  Future<List<String>> getFavouriteTodos() async {
    try {
      return sharedPreferences.getStringList(_todoFavouriteKey) ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<void> setFavouriteTodos(List<String> todoIds) async {
    try {
      await sharedPreferences.setStringList(_todoFavouriteKey, todoIds);
    } catch (e) {
      return;
    }
  }
}
