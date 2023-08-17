import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

part 'task_mapper.dart';

/// Model for [Task]
class TaskModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool completed;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.completed,
  });

  @override
  List<Object?> get props => [id, title, description, dueDate, completed];

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        dueDate: DateTime.parse(json['dueDate']),
        completed: json['completed'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'completed': completed,
    };
  }
}
