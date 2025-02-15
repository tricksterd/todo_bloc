import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo_model.dart';
import '../todo_filter/todo_filter_cubit.dart';
import '../todo_list/todo_list_cubit.dart';
import '../todo_search/todo_search_cubit.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodos;

  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;

  late final StreamSubscription _todoFilterSubscription;
  late final StreamSubscription _todoSearchSubscription;
  late final StreamSubscription _todoListSubscription;

  FilteredTodosCubit({
    required this.initialTodos,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
  }) : super(FilteredTodosState(
          filteredTodos: initialTodos,
        )) {
    _todoFilterSubscription =
        todoFilterCubit.stream.listen((TodoFilterState state) {
      _setFilteredTodos();
    });

    _todoSearchSubscription =
        todoSearchCubit.stream.listen((TodoSearchState state) {
      _setFilteredTodos();
    });

    _todoListSubscription = todoListCubit.stream.listen((TodoListState state) {
      _setFilteredTodos();
    });
  }

  void _setFilteredTodos() {
    List<Todo> filteredTodos;
    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        filteredTodos = todoListCubit.state.todos
            .where((todo) => !todo.isCompleted)
            .toList();
        break;
      case Filter.completed:
        filteredTodos = todoListCubit.state.todos
            .where((todo) => todo.isCompleted)
            .toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todoListCubit.state.todos;
        break;
    }
    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodos: filteredTodos));
  }

  @override
  Future<void> close() {
    _todoFilterSubscription.cancel();
    _todoSearchSubscription.cancel();
    _todoListSubscription.cancel();
    return super.close();
  }
}
