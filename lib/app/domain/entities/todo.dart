
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Todo extends Equatable {
  final String id;
  final String text;
  final bool completed;

  Todo({
    this.id,
    @required this.text,
    @required this.completed
  }) : super([id, text, completed]);

  @override
  String toString() {
    return "Todo{id: $id, text: $text, completed: $completed}";
  }
}

