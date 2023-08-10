import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool completed;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.completed = false,
  });

  @override
  List<Object?> get props => [id, title, description, dueDate, completed];
}
