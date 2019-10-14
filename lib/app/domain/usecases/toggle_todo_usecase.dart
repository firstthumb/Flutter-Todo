import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/app/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:flutter_todo_simple/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class ToggleTodoUseCase implements UseCase<List<Todo>, ToggleTodoParam> {
  final TodoRepository repository;

  ToggleTodoUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call(ToggleTodoParam params) async {
    return await repository.toggleTodo(params.id);
  }
}

class ToggleTodoParam extends Params {
  final String id;

  ToggleTodoParam({@required this.id}) : super([id]);
}
