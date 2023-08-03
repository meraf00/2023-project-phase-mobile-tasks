import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/date_field.dart';
import '../widgets/text_field.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

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
            const CustomTextField(
              label: "Main task name",
            ),
            const SizedBox(height: 30),
            const DateField(
              label: "Due date",
            ),
            const SizedBox(height: 30),
            const CustomTextField(
              label: "Description",
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 30),
            Button(
              label: "Add task",
              onPressed: () {},
              borderRadius: BorderRadius.circular(9999),
            ),
          ],
        ),
      ),
    );
  }
}
