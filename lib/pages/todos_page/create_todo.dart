import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/todo_list/todo_list_cubit.dart';

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
          context.read<TodoListCubit>().addTodo(desc);
          newTodoController.clear();
        }
      },
    );
  }
}
