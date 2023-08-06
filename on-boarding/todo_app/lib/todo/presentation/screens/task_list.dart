import 'package:flutter/material.dart';
import '../../../core/util.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import '../screens/add_task.dart';
import '../screens/task_detail.dart';
import '../widgets/button.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  static const routeName = "tasks";

  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  var _tasks = <Task>[];

  Future<void> loadTasks() async {
    final allTasks = await TaskRepository().getTasks();

    setState(() {
      _tasks = allTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Center(
          child: Text(
            'Todo List',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child:
                    Text('Close', style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .25,
              child: Image.asset(
                "assets/images/task_list.png",
              ),
            ),
            const SizedBox(height: 30),
            //
            Text(
              "Tasks list",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          TaskDetailScreen.routeName,
                          arguments: task,
                        );

                        loadTasks();
                      },
                      child: TaskCard(
                        title: task.title,
                        deadline: dateTimeToString(task.dueDate),
                        completed: task.completed,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: Button(
                label: "Create task",
                onPressed: () async {
                  await Navigator.pushNamed(context, AddTaskScreen.routeName);

                  await loadTasks();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
