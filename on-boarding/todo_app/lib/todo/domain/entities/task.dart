class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool completed;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.completed,
  });

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, dueDate: $dueDate, completed: $completed)';
  }
}
