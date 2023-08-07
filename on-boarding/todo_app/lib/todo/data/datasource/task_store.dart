import '../../domain/entities/task.dart';

class TaskStore {
  final List<Task> _tasks = [];
  var _id = 0;

  Future<Task> getTask(int id) async {
    return _tasks.firstWhere((element) => element.id == id);
  }

  Future<List<Task>> getTasks() async {
    return _tasks.toList();
  }

  Future<void> createTask(Task task) async {
    _tasks.add(Task(
        id: _id++,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate,
        completed: task.completed));
  }

  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
  }

  Future<void> deleteTask(int id) async {
    _tasks.removeWhere((element) => element.id == id);
  }
}
