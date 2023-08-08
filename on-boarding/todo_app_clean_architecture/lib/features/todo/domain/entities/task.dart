import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [id, title, description, dueDate];
}
