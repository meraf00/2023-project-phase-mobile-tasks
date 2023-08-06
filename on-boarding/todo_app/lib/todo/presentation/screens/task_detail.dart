import 'package:flutter/material.dart';

import '../../data/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import 'add_task.dart';

class TaskDetailScreen extends StatefulWidget {
  final List<String> _months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final Task task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Task task;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  void _deleteTask(BuildContext context) async {
    await TaskRepository().deleteTask(task.id!);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void _updateTask(BuildContext context) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(task: task),
      ),
    ) as Task;

    setState(() {
      task = updatedTask;
    });
  }

  void _toggleComplete(BuildContext context) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      completed: !task.completed,
    );
    await TaskRepository().updateTask(updatedTask);

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
            'Task detail',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit') {
                _updateTask(context);
              } else if (value == "toggle_complete") {
                _toggleComplete(context);
              } else if (value == "delete") {
                _deleteTask(context);
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: "edit",
                child:
                    Text('Edit', style: Theme.of(context).textTheme.bodySmall),
              ),
              PopupMenuItem(
                value: "toggle_complete",
                child: Text(
                    task.completed ? 'Mark as incomplete' : 'Mark as complete',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              PopupMenuItem(
                value: "delete",
                child: Text('Delete',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .3,
              child: Image.asset(
                "assets/images/ui_design.png",
              ),
            ),
            const SizedBox(height: 30),

            //
            Text(
              "Title",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  task.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),

            const SizedBox(height: 20),

            //
            Text(
              "Description",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),

            const SizedBox(height: 20),

            //
            Text(
              "Deadline",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${widget._months[task.dueDate.month - 1]} ${task.dueDate.day}, ${task.dueDate.year}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
