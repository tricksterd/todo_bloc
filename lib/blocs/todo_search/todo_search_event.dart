part of 'todo_search_bloc.dart';

sealed class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class SetSearchTermEvent extends TodoSearchEvent {
  final String newSearch;
  const SetSearchTermEvent({
    required this.newSearch,
  });

  @override
  String toString() => 'SetSearchTermEvent(newSearch: $newSearch)';

  @override
  List<Object> get props => [newSearch];
}
