import 'dart:io';

import 'package:flutter_todo_simple/app/data/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_simple/app/data/models/todo_model.dart';
import 'package:flutter_todo_simple/app/data/repositories/todo_repository_impl.dart';
import 'package:flutter_todo_simple/app/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_simple/app/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_todo_simple/app/domain/usecases/get_todo_list_usecase.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {

  final appDir = await getApplicationDocumentsDirectory();

  // Initialize Hive
  Hive.init(appDir.path);
  // Register TodoModelAdapter
  Hive.registerAdapter(TodoModelAdapter(), 0);

  // Open TodoModel Box
  final box = await Hive.openBox("TodoModel");

  // Hive
  sl.registerLazySingleton<Box>(() => box);

  // Bloc
  sl.registerFactory<TodoBloc>(() => TodoBloc(getTodoList: sl(), addTodo: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTodoListUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddTodoUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(localDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSourceImpl(todoBox: sl()));
}