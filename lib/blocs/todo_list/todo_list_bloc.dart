import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<RemoveTodoEvent>(_removeTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoListState> emit) {
    final newTodo = Todo(desc: event.decs);
    emit(state.copyWith(todos: [...state.todos, newTodo]));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map((todo) {
      if (todo.id == event.id) {
        return Todo(
          id: todo.id,
          desc: event.newDesc,
          isCompleted: todo.isCompleted,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos
        .where(
          (todo) => todo.id != event.id,
        )
        .toList();
    emit(state.copyWith(todos: newTodos));
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map((todo) {
      if (todo.id == event.id) {
        return Todo(
          id: todo.id,
          desc: todo.desc,
          isCompleted: !todo.isCompleted,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }
}
