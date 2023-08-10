import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_clean_architecture/core/presentation/util/input_validator.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/app_bar.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/custom_button.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/custom_date_field.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/snackbar.dart';
import 'package:todo_app_clean_architecture/injection_container.dart';

import '../../domain/entities/task.dart';
import '../widgets/custom_text_field.dart';

class CreateTaskScreen extends StatelessWidget {
  static const routeName = '/create-task';

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final Task? task;

  CreateTaskScreen({
    super.key,
    this.task,
  }) {
    if (task != null) {
      titleController.text = task!.title;
      descriptionController.text = task!.description;
      dueDateController.text = task!.dueDate.toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: task != null ? "Update task" : "Create new task",
        ),

        // body
        body: BlocProvider(
          create: (_) => serviceLocator<TaskBloc>(),
          child: BlocConsumer<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskError) {
                showError(context, state.message);
              }

              // updated
              else if (state is TaskUpdated) {
                showSuccess(context, "Task updated successfully");
                Navigator.of(context).pop();
              }

              // created
              else if (state is TaskCreated) {
                showSuccess(context, "Task created successfully");
                Navigator.of(context).pop();
              }
            },

            //
            builder: (context, state) => buildForm(context),
          ),
        ));
  }

  Widget buildForm(context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: "Main task name",
              controller: titleController,
              validator: titleValidator,
            ),
            const SizedBox(height: 30),
            CustomDateField(
              label: "Due date",
              controller: dueDateController,
              validator: dateValidator,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              label: "Description",
              controller: descriptionController,
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              validator: descriptionValidator,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: task != null ? "Update task" : "Add task",
              onPressed: () => task != null
                  ? dispatchUpdate(context)
                  : dispatchCreate(context),
              borderRadius: BorderRadius.circular(9999),
            ),
          ],
        ),
      ),
    );
  }

  void dispatchCreate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<TaskBloc>(context).add(CreateTask(
        titleController.text,
        descriptionController.text,
        dueDateController.text,
      ));
    }
  }

  void dispatchUpdate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<TaskBloc>(context).add(UpdateTask(
          task!.id,
          titleController.text,
          descriptionController.text,
          dueDateController.text,
          task!.completed));
    }
  }
}
