import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class is a stub for workshop participants to implement
@injectable
class TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  // ignore: unused_field
  final String _todoKey = 'todos';

  TodoLocalDataSource(this.sharedPreferences);
}
