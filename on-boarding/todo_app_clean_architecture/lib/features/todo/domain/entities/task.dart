import 'package:equatable/equatable.dart';

class Task extends Equatable {
  /// Unique identifier for the task
  final int id;

  /// Title of the task
  final String title;

  /// Description of the task
  final String description;

  /// Due date of the task
  final DateTime dueDate;

  /// Whether the task is completed
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
