import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/todo_list/todo_list_cubit.dart';

class ActiveTodoCountCubit extends Cubit<int> {
  final int initialActiveTodoCount;
  final TodoListCubit todoListCubit;
  late final StreamSubscription _todoListSubscription;

  ActiveTodoCountCubit({
    required this.initialActiveTodoCount,
    required this.todoListCubit,
  }) : super(initialActiveTodoCount) {
    _todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      final int currentActiveTodoCount = todoListState.todos
          .where((todo) => !todo.isCompleted)
          .toList()
          .length;
      emit(currentActiveTodoCount);
    });
  }

  @override
  Future<void> close() {
    _todoListSubscription.cancel();
    return super.close();
  }
}
