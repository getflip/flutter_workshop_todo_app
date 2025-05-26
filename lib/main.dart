import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'features/todo/data/repositories/todo_repository.dart';
import 'features/todo/presentation/cubits/todo_cubit.dart';
import 'features/todo/presentation/screens/todo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      home: BlocProvider(
        create: (_) {
          // Load todos when app starts
          return TodoCubit(getIt<TodoRepository>())..loadTodos();
        },
        child: const TodoListScreen(),
      ),
    );
  }
}
