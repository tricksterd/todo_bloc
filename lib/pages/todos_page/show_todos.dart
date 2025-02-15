import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/cubits.dart';

import '../../models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListCubit, TodoListState>(listener: (context, state) {
          context.read<FilteredTodosCubit>().setFilteredTodos(
                context.read<TodoFilterCubit>().state.filter,
                state.todos,
                context.read<TodoSearchCubit>().state.searchTerm,
              );
        }),
        BlocListener<TodoFilterCubit, TodoFilterState>(
            listener: (context, state) {
          context.read<FilteredTodosCubit>().setFilteredTodos(
                state.filter,
                context.read<TodoListCubit>().state.todos,
                context.read<TodoSearchCubit>().state.searchTerm,
              );
        }),
        BlocListener<TodoSearchCubit, TodoSearchState>(
            listener: (context, state) {
          context.read<FilteredTodosCubit>().setFilteredTodos(
                context.read<TodoFilterCubit>().state.filter,
                context.read<TodoListCubit>().state.todos,
                state.searchTerm,
              );
        }),
      ],
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: ValueKey(todos[index].id),
                background: showBackground(0),
                secondaryBackground: showBackground(1),
                onDismissed: (_) {
                  context.read<TodoListCubit>().removeTodo(
                        todos[index].id,
                      );
                },
                confirmDismiss: (_) {
                  return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text('Do you really want to delete?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('NO')),
                            TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('YES')),
                          ],
                        );
                      });
                },
                child: TodoItem(
                  todo: todos[index],
                ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.grey,
            );
          },
          itemCount: todos.length),
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        bool error = false;
        textController.text = widget.todo.desc;

        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: error ? 'Value cannot be empty' : null),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          error =
                              textController.text.trim().isEmpty ? true : false;
                          if (!error) {
                            context.read<TodoListCubit>().updateTodo(
                                  widget.todo.id,
                                  textController.text,
                                );
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('EDIT'),
                    )
                  ],
                );
              });
            });
      },
      leading: Checkbox(
          value: widget.todo.isCompleted,
          onChanged: (bool? checked) {
            context.read<TodoListCubit>().toggleTodo(
                  widget.todo.id,
                );
          }),
      title: Text(widget.todo.desc),
    );
  }
}
