import 'package:equatable/equatable.dart';
import 'package:flutter_todo_simple/app/domain/entities/visibility_filter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodoEvent extends Equatable {
  TodoEvent([List props = const <dynamic>[]]) : super(props);
}

class GetTodoListEvent extends TodoEvent {
  final VisibilityFilter filter;

  GetTodoListEvent({@required this.filter}) : super([filter]);

  @override
  String toString() => "GetTodoListEvent{ filter: $filter }";
}

class AddTodoEvent extends TodoEvent {
  final String text;
  final VisibilityFilter filter;

  AddTodoEvent({this.text, this.filter = VisibilityFilter.all}) : super([text, filter]);

  @override
  String toString() => "AddTodoEvent{ text: $text, filter: $filter }";
}

class ClearCompletedEvent extends TodoEvent {
  final VisibilityFilter filter;

  ClearCompletedEvent({this.filter = VisibilityFilter.all}) : super([filter]);

  @override
  String toString() => "ClearCompletedEvent{ filter: $filter }";
}

class ToggleTodoEvent extends TodoEvent {
  final String id;
  final VisibilityFilter filter;

  ToggleTodoEvent({@required this.id, this.filter = VisibilityFilter.all}) : super([id, filter]);

  @override
  String toString() => "ToggleTodoEvent{ id: $id, filter: $filter }";
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  final VisibilityFilter filter;

  DeleteTodoEvent({@required this.id, this.filter = VisibilityFilter.all}) : super([id, filter]);

  @override
  String toString() => "DeleteTodoEvent{ id: $id, filter: $filter }";
}
