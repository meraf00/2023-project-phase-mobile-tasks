import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/data/repositories/task_repository.dart';
import 'package:todo_app/todo/presentation/screens/add_task.dart';

void main() {
  group('Test add task', () {
    testWidgets('contains three text fields', (tester) async {
      final taskRepository = TaskRepository();

      final widget =
          MaterialApp(home: AddTaskScreen(taskRepository: taskRepository));

      await tester.pumpWidget(widget);

      expect(find.byType(TextField), findsNWidgets(3));
    });
  });
}
