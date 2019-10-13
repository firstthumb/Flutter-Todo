import 'package:equatable/equatable.dart';
import 'package:flutter_todo_simple/app/domain/entities/visibility_filter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodoEvent extends Equatable {
  TodoEvent([List props = const <dynamic>[]]) : super(props);
}

class GetTodoListEvent extends TodoEvent {
  final VisibilityFilter filter;

  GetTodoListEvent({@required this.filter});

  @override
  String toString() => "GetTodoListEvent{ filter: $filter }";
}

class AddTodoEvent extends TodoEvent {
  final String text;

  AddTodoEvent({this.text}) : super([text]);

  @override
  String toString() => "AddTodoEvent{ text: $text }";
}

class ClearCompletedEvent extends TodoEvent {
  @override
  String toString() => "ClearCompletedEvent{ }";
}

class ToggleTodoEvent extends TodoEvent {
  final String id;

  ToggleTodoEvent({@required this.id});

  @override
  String toString() => "ToggleTodoEvent{ id: $id }";
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent({@required this.id});

  @override
  String toString() => "DeleteTodoEvent{ id: $id }";
}
