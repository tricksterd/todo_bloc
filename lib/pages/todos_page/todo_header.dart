import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';

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
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            final int activeTodoCount =
                state.todos.where((todo) => !todo.isCompleted).toList().length;
            context
                .read<ActiveTodoCountCubit>()
                .calculateActiveTodoCount(activeTodoCount);
          },
          child: Text(
            '${context.watch<ActiveTodoCountCubit>().state} items left',
            style: const TextStyle(fontSize: 20, color: Colors.redAccent),
          ),
        )
      ],
    );
  }
}
