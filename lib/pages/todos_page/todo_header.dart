import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/todo_model.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(fontSize: 40),
        ),
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            context.read<ActiveTodoCountBloc>().add(
                CalculateActiveTodoCountEvent(
                    activeTodoCount: state.todos
                        .where((Todo todo) => !todo.isCompleted)
                        .toList()
                        .length));
          },
          child: Text(
            '${context.watch<ActiveTodoCountBloc>().state.activeTodoCount} items left',
            style: const TextStyle(fontSize: 20, color: Colors.redAccent),
          ),
        )
      ],
    );
  }
}
