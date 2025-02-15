import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo/blocs/todo_search/todo_search_bloc.dart';

import '../../models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  late final StreamSubscription _filterSubscription;
  late final StreamSubscription _searchSubscription;
  late final StreamSubscription _todoListSubscription;

  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoListBloc todoListBloc;

  final List<Todo> initialTodos;

  FilteredTodosBloc({
    required this.initialTodos,
    required this.todoFilterBloc,
    required this.todoSearchBloc,
    required this.todoListBloc,
  }) : super(FilteredTodosState(filteredTodos: initialTodos)) {
    _filterSubscription = todoFilterBloc.stream.listen((TodoFilterState state) {
      setFilteredTodos();
    });

    _searchSubscription = todoSearchBloc.stream.listen((TodoSearchState state) {
      setFilteredTodos();
    });

    _todoListSubscription = todoListBloc.stream.listen((TodoListState state) {
      setFilteredTodos();
    });

    on<CalculateFilteredTodosEvent>((event, emit) {
      emit(state.copyWith(filteredTodos: event.filteredTodos));
    });
  }

  void setFilteredTodos() {
    List<Todo> filteredTodos;
    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        filteredTodos = todoListBloc.state.todos
            .where((todo) => !todo.isCompleted)
            .toList();
        break;
      case Filter.completed:
        filteredTodos =
            todoListBloc.state.todos.where((todo) => todo.isCompleted).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todoListBloc.state.todos;
        break;
    }
    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((todo) =>
              todo.desc.toLowerCase().contains(todoSearchBloc.state.searchTerm))
          .toList();
    }

    add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
  }

  @override
  Future<void> close() {
    _filterSubscription.cancel();
    _searchSubscription.cancel();
    _todoListSubscription.cancel();
    return super.close();
  }
}
