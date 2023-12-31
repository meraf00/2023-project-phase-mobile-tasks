import 'package:flutter/material.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import '../widgets/button.dart';
import '../widgets/date_field.dart';
import '../widgets/text_field.dart';

class AddTaskScreen extends StatelessWidget {
  static const routeName = '/add-task';

  final _taskTitleController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  final _taskDueDateController = TextEditingController();
  final Task? task;
  final TaskRepository taskRepository;

  AddTaskScreen({Key? key, this.task, required this.taskRepository})
      : super(key: key) {
    if (task != null) {
      _taskTitleController.text = task!.title;
      _taskDescriptionController.text = task!.description;
      _taskDueDateController.text = task!.dueDate.toString();
    }
  }

  bool isValid() {
    if (_taskTitleController.text.isNotEmpty &&
        _taskDescriptionController.text.isNotEmpty &&
        _taskDueDateController.text.isNotEmpty) {
      return DateTime.tryParse(_taskDueDateController.text) != null;
    }

    return false;
  }

  void _updateTask(BuildContext context) async {
    if (!isValid()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(DateTime.tryParse(_taskDueDateController.text) == null
              ? "Invalid date format"
              : "All fields are required")));

      return;
    }

    final updatedTask = Task(
      id: task!.id,
      title: _taskTitleController.text,
      description: _taskDescriptionController.text,
      dueDate: DateTime.parse(_taskDueDateController.text),
      completed: task!.completed,
    );
    await taskRepository.updateTask(updatedTask);

    if (context.mounted) {
      Navigator.pop(context, updatedTask);
    }
  }

  void _addTask(BuildContext context) async {
    if (!isValid()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(DateTime.tryParse(_taskDueDateController.text) == null
              ? "Invalid date format"
              : "All fields are required")));

      return;
    }

    final task = Task(
      title: _taskTitleController.text,
      description: _taskDescriptionController.text,
      dueDate: DateTime.parse(_taskDueDateController.text),
      completed: false,
    );
    await taskRepository.addTask(task);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Center(
          child: Text(
            'Create new task',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Settings',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            CustomTextField(
              label: "Main task name",
              controller: _taskTitleController,
            ),
            const SizedBox(height: 30),
            DateField(
              label: "Due date",
              controller: _taskDueDateController,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              label: "Description",
              controller: _taskDescriptionController,
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 30),
            Button(
              label: task != null ? "Update task" : "Add task",
              onPressed: () =>
                  task != null ? _updateTask(context) : _addTask(context),
              borderRadius: BorderRadius.circular(9999),
            ),
          ],
        ),
      ),
    );
  }
}
