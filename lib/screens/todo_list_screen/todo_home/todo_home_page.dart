import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_play_with_bloc/blocs/todo_list/todo/todo_bloc.dart';
import 'package:flutter_play_with_bloc/blocs/todo_list/todo_task/todo_task.dart';

import '../../screen.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({Key? key}) : super(key: key);

  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TodoListBloc>(
            create: (BuildContext context) => TodoListBloc(),
          ),
          BlocProvider<TodoTaskBloc>(
            create: (BuildContext context) =>
                TodoTaskBloc(todoBloc: TodoListBloc()),
          ),
        ],
        child: TodoHomeForm(),
      ),
    );
  }
}
