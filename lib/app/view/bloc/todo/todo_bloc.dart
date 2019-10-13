import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_todo_simple/app/domain/usecases/get_todo_list_usecase.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_event.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_state.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:flutter_todo_simple/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodoListUseCase getTodoList;
  final AddTodoUseCase addTodo;

  TodoBloc({@required this.getTodoList, @required this.addTodo});

  @override
  TodoState get initialState {
    print("***** TodoBloc initialState");
    return Empty();
  }

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    print("***** TodoBloc mapEventToState $event");

    if (event is GetTodoListEvent) {
      yield Loading();
//      final result = await getTodoList(NoParams());
//      yield* result.fold(
//              (failure) => Error(message: "Error"),
//              (todoList) => Loaded(todos: todoList),
//      );
//      yield* _eitherLoadedOrErrorState(result);


      yield* (await getTodoList(NoParams())).fold(
          (failure) async* {
            print("***** getTodo Failure $failure");
            yield Error(message: "");
          },
          (todoList) async* {
            print("***** getTodo success $todoList");
            yield Loaded(todos: todoList);
          }
      );
    } else if (event is AddTodoEvent) {
      yield Loading();
      final eitherFailOrList = await addTodo.call(Params(text: event.text));
      yield* eitherFailOrList.fold(
          (failure) async* {
            print("***** addTodo Failure $failure");
            yield Error(message: "");
          },
          (todoList) async* {
            print("***** addTodo success $todoList");
            yield Loaded(todos: todoList);
          }
      );
//      yield* (await addTodo(Params(text: event.text))).fold(
//          (failure) async* {
//            yield Error(message: "");
//          },
//          (todoList) async* {
//            yield Loaded(todos: todoList);
//          }
//      );
    }
  }

//  Stream<TodoState> _eitherLoadedOrErrorState(Either<Failure, List<Todo>> failureOrTrivia,
//      ) async* {
//    yield failureOrTrivia.fold(
//          (failure) => Error(message: "Error"),
//          (todoList) => Loaded(todos: todoList),
//    );
//  }
}
