import './task.dart';

class TaskManager {
  final _tasks = <Task>[];

  void addTask(Task task) {
    tasks.add(task);
  }

  void removeTask(Task task) {
    tasks.remove(task);
  }

  List<Task> get tasks => _tasks;

  List<Task> get pendingTasks =>
      tasks.where((task) => task.status == Status.pending).toList();

  List<Task> get completedTasks =>
      tasks.where((task) => task.status == Status.completed).toList();

  List<Task> filterTasks([Status? filter]) {
    if (filter == Status.pending) {
      return pendingTasks;
    } else if (filter == Status.completed) {
      return completedTasks;
    } else {
      return tasks;
    }
  }
}
