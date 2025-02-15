import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    on<SetSearchTermEvent>((event, emit) {
      emit(state.copyWith(searchTerm: event.newSearch));
    });
  }

  EventTransformer<SetSearchTermEvent> debounce<SetSearchTermEvent>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
