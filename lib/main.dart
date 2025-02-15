import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
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
          create: (context) => TodoFilterBloc(),
        ),
        BlocProvider(
          create: (context) => TodoSearchBloc(),
        ),
        BlocProvider(
          create: (context) => TodoListBloc(),
        ),
        BlocProvider(
          create: (context) => ActiveTodoCountBloc(
            initialActiveTodoCount:
                context.read<TodoListBloc>().state.todos.length,
            todoListBloc: context.read<TodoListBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => FilteredTodosBloc(
            initialTodos: context.read<TodoListBloc>().state.todos,
            todoFilterBloc: context.read<TodoFilterBloc>(),
            todoSearchBloc: context.read<TodoSearchBloc>(),
            todoListBloc: context.read<TodoListBloc>(),
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
