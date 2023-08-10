import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../screens/task_detail_screen.dart';
import 'task_card.dart';

class TasksListView extends StatefulWidget {
  final List<Task> tasks;

  const TasksListView({super.key, required this.tasks});

  @override
  State<StatefulWidget> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isEmpty) {
      return const Expanded(
          child: Center(
        child: Text('No tasks found, why not add one?'),
      ));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          final task = widget.tasks[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  TaskDetailScreen.routeName,
                  arguments: task.id,
                );

                if (mounted) {
                  context.read<TaskBloc>().add(GetTasks());
                }
              },
              child: TaskCard(
                title: task.title,
                deadline: task.dueDate,
                completed: task.completed,
              ),
            ),
          );
        },
      ),
    );
  }
}
