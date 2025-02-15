import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Filter {
  all,
  active,
  completed,
}

Uuid uuid = const Uuid();

class Todo extends Equatable {
  final String id;
  final String desc;
  final bool isCompleted;

  Todo({
    String? id,
    required this.desc,
    this.isCompleted = false,
  }) : id = id ?? uuid.v4();

  @override
  List<Object?> get props => [id, desc, isCompleted];

  @override
  String toString() =>
      'TodoModel(id: $id, desc: $desc, isCompleted: $isCompleted)';
}
