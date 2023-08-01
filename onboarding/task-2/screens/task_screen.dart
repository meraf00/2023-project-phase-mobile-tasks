import 'dart:io';
import '../models/task_manager.dart';
import '../models/task.dart';
import './main_screen.dart';
import './screen.dart';
import './task_list_screen.dart';

class TaskScreen extends Screen {
  final Task _task;
  final TaskManager _taskManager;

  TaskScreen(this._task, this._taskManager)
      : super([
          "Mark as completed",
          "Mark as pending",
          "Update task",
          "Delete task",
          "Back to main menu"
        ]) {
    viewTask();
  }

  void viewTask() {
    print("-------------------------------------------");
    print("${_task.title} [${_task.status}]");
    print(
        "Due Date: ${_task.dueDate.year}-${_task.dueDate.month}-${_task.dueDate.day}\n");
    print(_task.description);
    print("-------------------------------------------\n");
  }

  void updateTask() {
    print("Update task (leave it empty to keep the old value)");

    print("\n[${_task.title}]");
    print("New task title:");
    var title = stdin.readLineSync()!;

    if (title.isNotEmpty) {
      _task.title = title;
    }

    print("\n[${_task.description}]");
    print("New task description:");
    var description = stdin.readLineSync()!;

    if (description.isNotEmpty) {
      _task.description = description;
    }

    print(
        "\n[${_task.dueDate.year}-${_task.dueDate.month}-${_task.dueDate.day}]");
    do {
      print("New task due date (yyyy-mm-dd):");
      var dueDate = stdin.readLineSync()!;

      if (dueDate.isNotEmpty) {
        var dueDateParsed = DateTime.tryParse(dueDate);

        if (dueDateParsed == null) {
          print("Invalid date format.");
        } else {
          _task.dueDate = dueDateParsed;
          break;
        }
      } else {
        return;
      }
    } while (true);
  }

  @override
  Screen handleInput(int option) {
    switch (option) {
      case 1:
        _task.markCompleted();
      case 2:
        _task.markPending();
      case 3:
        updateTask();
      case 4:
        _taskManager.removeTask(_task);
      case 5:
        return MainScreen(_taskManager);
      default:
        print("Invalid option");
        return this;
    }
    return TaskListScreen(_taskManager);
  }
}
