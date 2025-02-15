import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo_model.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodos;

  FilteredTodosCubit({
    required this.initialTodos,
  }) : super(FilteredTodosState(
          filteredTodos: initialTodos,
        ));

  void setFilteredTodos(
    Filter filter,
    List<Todo> todos,
    String searchTerm,
  ) {
    List<Todo> filteredTodos;
    switch (filter) {
      case Filter.active:
        filteredTodos = todos.where((todo) => !todo.isCompleted).toList();
        break;
      case Filter.completed:
        filteredTodos = todos.where((todo) => todo.isCompleted).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todos;
        break;
    }
    if (searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodos: filteredTodos));
  }
}
