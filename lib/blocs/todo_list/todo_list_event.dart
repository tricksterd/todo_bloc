part of 'todo_list_bloc.dart';

sealed class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoListEvent {
  final String decs;
  const AddTodoEvent({
    required this.decs,
  });

  @override
  String toString() => 'AddTodoEvent(decs: $decs)';

  @override
  List<Object> get props => [decs];
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String newDesc;

  const EditTodoEvent({
    required this.id,
    required this.newDesc,
  });

  @override
  String toString() => 'EditTodoEvent(id: $id, newDesc: $newDesc)';

  @override
  List<Object> get props => [id, newDesc];
}

class ToggleTodoEvent extends TodoListEvent {
  final String id;
  const ToggleTodoEvent({
    required this.id,
  });

  @override
  String toString() => 'ToggleTodoEvent(id: $id)';

  @override
  List<Object> get props => [id];
}

class RemoveTodoEvent extends TodoListEvent {
  final String id;
  const RemoveTodoEvent({
    required this.id,
  });

  @override
  String toString() => 'RemoveTodoEvent(id: $id)';

  @override
  List<Object> get props => [id];
}
