import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/domain/entities/visibility_filter.dart';
import 'package:flutter_todo_simple/app/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_todo_simple/app/domain/usecases/clear_complete_todo_usecase.dart';
import 'package:flutter_todo_simple/app/domain/usecases/delete_todo_usecase.dart';
import 'package:flutter_todo_simple/app/domain/usecases/get_todo_list_usecase.dart';
import 'package:flutter_todo_simple/app/domain/usecases/toggle_todo_usecase.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_event.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_state.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:flutter_todo_simple/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodoListUseCase getTodoList;
  final AddTodoUseCase addTodo;
  final DeleteTodoUseCase deleteTodo;
  final ToggleTodoUseCase toggleTodo;
  final ClearCompletedTodoUseCase clearCompletedTodo;

  TodoBloc({
    @required this.getTodoList,
    @required this.addTodo,
    @required this.deleteTodo,
    @required this.toggleTodo,
    @required this.clearCompletedTodo,
  });

  @override
  TodoState get initialState => Empty();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is GetTodoListEvent) {
      yield Loading();
      yield* _mapLoadTodoToState(await getTodoList(GetTodoListParam(filter: event.filter)), event.filter);
    } else if (event is AddTodoEvent) {
      yield Loading();
      yield* _mapAddTodoToState(await addTodo(AddTodoParam(text: event.text)), event.filter);
    } else if (event is ToggleTodoEvent) {
      yield Loading();
      yield* _mapToggleTodoToState(await toggleTodo(ToggleTodoParam(id: event.id)), event.filter);
    } else if (event is DeleteTodoEvent) {
      yield Loading();
      yield* _mapDeleteTodoToState(await deleteTodo(DeleteTodoParam(id: event.id)), event.filter);
    } else if (event is ClearCompletedEvent) {
      yield Loading();
      yield* _mapClearCompletedTodoToState(await clearCompletedTodo(NoParams()), event.filter);
    }
  }

  Stream<TodoState> _mapLoadTodoToState(Either<Failure, List<Todo>> either, VisibilityFilter filter) async* {
    yield either.fold(
          (failure) => Error(message: "Load todo failed : $failure"),
          (todoList) => Loaded(todos: todoList, filter: filter),
    );
  }

  Stream<TodoState> _mapAddTodoToState(Either<Failure, List<Todo>> either, VisibilityFilter filter) async* {
    yield either.fold(
          (failure) => Error(message: "Add todo failed : $failure"),
          (todoList) => Loaded(todos: todoList, filter: filter),
    );
  }

  Stream<TodoState> _mapToggleTodoToState(Either<Failure, List<Todo>> either, VisibilityFilter filter) async* {
    yield either.fold(
          (failure) => Error(message: "Toggle todo failed : $failure"),
          (todoList) => Loaded(todos: todoList, filter: filter),
    );
  }

  Stream<TodoState> _mapDeleteTodoToState(Either<Failure, List<Todo>> either, VisibilityFilter filter) async* {
    yield either.fold(
          (failure) => Error(message: "Delete todo failed : $failure"),
          (todoList) => Loaded(todos: todoList, filter: filter),
    );
  }

  Stream<TodoState> _mapClearCompletedTodoToState(Either<Failure, List<Todo>> either, VisibilityFilter filter) async* {
    yield either.fold(
          (failure) => Error(message: "Clear completed todo failed : $failure"),
          (todoList) => Loaded(todos: todoList, filter: filter),
    );
  }
}
