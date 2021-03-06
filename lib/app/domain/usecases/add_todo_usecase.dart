import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/app/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:flutter_todo_simple/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class AddTodoUseCase implements UseCase<List<Todo>, AddTodoParam> {
  final TodoRepository repository;

  AddTodoUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call(AddTodoParam params) async {
    return await repository.addTodo(Todo(text: params.text, completed: false));
  }
}

class AddTodoParam extends Params {
  final String text;

  AddTodoParam({@required this.text}) : super([text]);
}
