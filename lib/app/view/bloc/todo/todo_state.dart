
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodoState extends Equatable {
  TodoState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TodoState {}

class Loading extends TodoState {}

class Loaded extends TodoState {
  final List<Todo> todos;

  Loaded({
    @required this.todos
  }) : super([todos]);
}

class Error extends TodoState {
  final String message;

  Error({
    @required this.message
  }) : super([message]);
}
