import 'package:add_task/feature/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../widgets/date_field.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            'Create new task',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert,
                  color: Theme.of(context).colorScheme.onBackground),
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
                const MyTextField(
                  label: "Main task name",
                ),
                const SizedBox(height: 30),
                const DateField(
                  label: "Due date",
                ),
                const SizedBox(height: 30),
                const MyTextField(
                  label: "Description",
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 30),
                Button(
                  label: "Add task",
                  onPressed: () {},
                ),
              ],
            )));
  }
}
