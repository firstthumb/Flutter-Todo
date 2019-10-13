import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_simple/app/domain/entities/visibility_filter.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_bloc.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_event.dart';
import 'package:flutter_todo_simple/app/view/page/home_view.dart';
import 'package:flutter_todo_simple/di/injection_container.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<TodoBloc> _buildBody(BuildContext context) {
    return BlocProvider<TodoBloc>(
      builder: (_) => sl<TodoBloc>()
        ..dispatch(GetTodoListEvent(filter: VisibilityFilter.all)),
      child: HomeView(),
    );
  }
}
