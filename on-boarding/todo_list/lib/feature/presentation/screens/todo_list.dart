import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final tasks = [
    {
      "title": "UI/UX App Design",
      "deadline": "April 29, 2023",
      "completed": true,
    },
    {
      "title": "UI/UX App Design",
      "deadline": "April 29, 2023",
      "completed": false,
    },
    {
      "title": "View candidates",
      "deadline": "April 29, 2023",
      "completed": false,
    },
    {
      "title": "Football dribbling",
      "deadline": "April 29, 2023",
      "completed": false,
    },
  ];

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
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TaskCard(
                      title: task['title']! as String,
                      deadline: task['deadline']! as String,
                      completed: task['completed']! as bool,
                    ),
                  );
                },
                itemCount: tasks.length,
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: Button(
                label: "Create task",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
