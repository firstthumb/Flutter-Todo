import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/app/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:flutter_todo_simple/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class DeleteTodoUseCase implements UseCase<List<Todo>, DeleteTodoParam> {
  final TodoRepository repository;

  DeleteTodoUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call(DeleteTodoParam params) async {
    return await repository.deleteTodo(params.id);
  }
}

class DeleteTodoParam extends Params {
  final String id;

  DeleteTodoParam({@required this.id}) : super([id]);
}
