import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);

    emit(state.copyWith(todos: [...state.todos, newTodo]));
    print(state);
  }

  void updateTodo(String id, String newDesc) {
    final newTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(id: todo.id, desc: newDesc, isCompleted: todo.isCompleted);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void removeTodo(String id) {
    final newTodos = state.todos
        .where(
          (todo) => todo.id != id,
        )
        .toList();
    emit(state.copyWith(todos: newTodos));
  }

  void toggleTodo(String id) {
    final newTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(
            id: todo.id, desc: todo.desc, isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }
}
