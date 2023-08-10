import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_clean_architecture/core/presentation/util/input_converter.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/screens/create_task_screen.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/app_bar.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/loading.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/snackbar.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/task_detail_card.dart';
import 'package:todo_app_clean_architecture/injection_container.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = "/task-detail";

  final int taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<TaskBloc>()..add(GetTask(taskId)),
      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskUpdated) {
            final message = state.task.completed ? 'complete' : 'incomplete';
            showSuccess(context, "Task marked as $message");
            Navigator.of(context).pop();
          } else if (state is TaskDeleted) {
            showSuccess(context, "Task deleted successfully");
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is TaskLoaded) {
            return Scaffold(
              appBar: CustomAppBar(
                title: 'Task detail',
                actions: buildActions(context, state.task),
              ),

              //
              body: buildBody(context, state.task),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  List<Widget> buildActions(BuildContext context, Task task) {
    return [
      PopupMenuButton(
        onSelected: (value) async {
          if (value == 'edit') {
            final taskBloc = context.read<TaskBloc>();

            await Navigator.pushNamed(context, CreateTaskScreen.routeName,
                arguments: task);

            taskBloc.add(GetTask(taskId));
          } else if (value == "toggle_complete") {
            context.read<TaskBloc>().add(UpdateTask(task.id, task.title,
                task.description, task.dueDate.toString(), !task.completed));
          } else if (value == "delete") {
            context.read<TaskBloc>().add(DeleteTask(task.id));
          }
        },
        icon: const Icon(Icons.more_vert),
        itemBuilder: (_) => [
          PopupMenuItem(
            value: "edit",
            child: Text('Edit', style: Theme.of(context).textTheme.bodySmall),
          ),
          PopupMenuItem(
            value: "toggle_complete",
            child: Text(
                task.completed ? 'Mark as incomplete' : 'Mark as complete',
                style: Theme.of(context).textTheme.bodySmall),
          ),
          PopupMenuItem(
            value: "delete",
            child: Text('Delete', style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      )
    ];
  }

  Widget buildBody(BuildContext context, Task task) {
    return SingleChildScrollView(
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

          //
          const SizedBox(height: 30),
          TaskDetailCard(title: "Title", content: task.title),

          //
          const SizedBox(height: 20),
          TaskDetailCard(title: "Description", content: task.description),

          //
          const SizedBox(height: 20),
          TaskDetailCard(
              title: "Deadline",
              content: serviceLocator<InputConverter>()
                  .dateTimeToString(task.dueDate)),
        ],
      ),
    );
  }
}
