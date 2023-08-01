enum Status { pending, completed }

class Task {
  String title;
  String description;
  DateTime dueDate;
  Status status = Status.pending;

  Task({required this.title, required this.description, required this.dueDate});

  void markCompleted() {
    status = Status.completed;
  }

  void markPending() {
    status = Status.pending;
  }
}
