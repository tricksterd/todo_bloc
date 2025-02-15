import 'package:flutter/material.dart';
import 'package:todo/pages/todos_page/create_todo.dart';
import 'package:todo/pages/todos_page/search_and_filter_todo.dart';
import 'package:todo/pages/todos_page/show_todos.dart';

import 'todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Column(
            children: [
              const TodoHeader(),
              const CreateTodo(),
              const SizedBox(
                height: 20,
              ),
              SearchAndFilterTodo(),
              const ShowTodos(),
            ],
          ),
        ),
      )),
    );
  }
}
