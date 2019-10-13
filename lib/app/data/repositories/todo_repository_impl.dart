
import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/data/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/app/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:meta/meta.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({
    @required this.localDataSource
  });

  @override
  Future<Either<Failure, List<Todo>>> getTodoList() async {
    final todoModelList = await localDataSource.getTodoList();
    return Right(todoModelList.map((todoModel) => todoModel.fromModel()).toList());
  }

  @override
  Future<Either<Failure, List<Todo>>> addTodo(Todo todo) async {
    final todoModel = await localDataSource.saveTodo(todo.text);
    return Right(todoModel.map((todoModel) => todoModel.fromModel()).toList());
  }
}