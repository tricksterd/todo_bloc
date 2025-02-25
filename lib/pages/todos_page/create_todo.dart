import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/todo_list/todo_list_bloc.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  late final TextEditingController newTodoController;
  @override
  void initState() {
    super.initState();
    newTodoController = TextEditingController();
  }

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newTodoController,
      decoration: const InputDecoration(labelText: 'What to do?'),
      onSubmitted: (String? desc) {
        if (desc != null && desc.trim().isNotEmpty) {
          context.read<TodoListBloc>().add(AddTodoEvent(decs: desc));
          newTodoController.clear();
        }
      },
    );
  }
}
