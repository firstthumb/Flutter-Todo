import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/app/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:flutter_todo_simple/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class GetTodoListUseCase implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  GetTodoListUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodoList();
  }
}
