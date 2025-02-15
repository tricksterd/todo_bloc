import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveTodoCountCubit extends Cubit<int> {
  final int initialActiveTodoCount;

  ActiveTodoCountCubit({
    required this.initialActiveTodoCount,
  }) : super(initialActiveTodoCount);

  void calculateActiveTodoCount(int activeTodoCount) {
    emit(activeTodoCount);
  }
}
