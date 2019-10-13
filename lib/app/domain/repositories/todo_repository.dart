
import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodoList();

  Future<Either<Failure, List<Todo>>> addTodo(Todo todo);
}