import 'dart:io';

import '../models/task_manager.dart';
import '../models/task.dart';
import './task_list_screen.dart';
import './screen.dart';

class MainScreen extends Screen {
  final TaskManager _taskManager;

  MainScreen(this._taskManager)
      : super([
          "Create new task",
          "View all tasks",
          "View pending tasks",
          "View completed tasks",
          "Exit"
        ]);

  Task createTask() {
    print("Create new task\n");

    print("Enter task title:");
    var title = stdin.readLineSync()!;

    print("Enter task description:");
    var description = stdin.readLineSync()!;

    do {
      print("Enter task due date (yyyy-mm-dd):");
      var dueDate = stdin.readLineSync()!;
      var dueDateParsed = DateTime.tryParse(dueDate);

      if (dueDateParsed == null) {
        print("Invalid date format.");
      } else {
        var task = Task(
            title: title, description: description, dueDate: dueDateParsed);
        return task;
      }
    } while (true);
  }

  @override
  Screen handleInput(int option) {
    switch (option) {
      case 1:
        var task = createTask();
        _taskManager.addTask(task);
        return MainScreen(_taskManager);
      case 2:
        return TaskListScreen(_taskManager);
      case 3:
        return TaskListScreen(_taskManager, filter: Status.pending);
      case 4:
        return TaskListScreen(_taskManager, filter: Status.completed);
      case 5:
        exit(0);
      default:
        print("Invalid option");
        return MainScreen(_taskManager);
    }
  }
}
