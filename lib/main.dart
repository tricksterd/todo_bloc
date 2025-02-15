import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/cubits.dart';
import 'pages/todos_page/todos_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider(
          create: (context) => ActiveTodoCountCubit(
            initialActiveTodoCount:
                context.read<TodoListCubit>().state.todos.length,
          ),
        ),
        BlocProvider(
          create: (context) => FilteredTodosCubit(
            initialTodos: context.read<TodoListCubit>().state.todos,
          ),
        ),
      ],
      child: const MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        home: TodosPage(),
      ),
    );
  }
}
