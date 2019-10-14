import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/app/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:flutter_todo_simple/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class ClearCompletedTodoUseCase implements UseCase<List<Todo>, Params> {
  final TodoRepository repository;

  ClearCompletedTodoUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call(Params params) async {
    return await repository.clearCompletedTodo();
  }
}

