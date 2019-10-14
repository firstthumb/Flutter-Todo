
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'todo_model.g.dart';

const String todoModelHiveName = "TodoModelHive";

@HiveType()
class TodoModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final bool completed;

  TodoModel({
    this.id,
    @required this.text,
    @required this.completed
  }) : super([id, text, completed]);

  Todo fromModel() {
    return Todo(id: id, text: text, completed: completed);
  }

  TodoModel toggle() {
    return TodoModel(id: this.id, text: this.text, completed: !this.completed);
  }

  @override
  String toString() => "TodoModel{ id: $id, text: $text, completed: $completed }";
}