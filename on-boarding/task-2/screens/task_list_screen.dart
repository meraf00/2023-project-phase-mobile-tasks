import '../models/task.dart';
import '../models/task_manager.dart';
import './screen.dart';
import '../screens/main_screen.dart';
import '../screens/task_screen.dart';

class TaskListScreen extends Screen {
  final TaskManager _taskManager;
  final Status? filter;

  TaskListScreen(this._taskManager, {Status? this.filter})
      : super(_taskManager
                .filterTasks(filter)
                .map((task) => "${task.title} [${task.status}]")
                .toList() +
            ["Back to main menu"]);

  @override
  Screen handleInput(int option) {
    var tasks = _taskManager.filterTasks(filter);

    if (option == tasks.length + 1) {
      return MainScreen(_taskManager);
    }

    var task = tasks[option - 1];
    return TaskScreen(task, _taskManager);
  }
}
