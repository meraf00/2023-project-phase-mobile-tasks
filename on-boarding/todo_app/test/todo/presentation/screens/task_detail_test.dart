import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/data/repositories/task_repository.dart';
import 'package:todo_app/todo/domain/entities/task.dart';
import 'package:todo_app/todo/presentation/screens/task_detail.dart';

void main() {
  group('Test task detail', () {
    testWidgets('displays image', (tester) async {
      final task = Task(
          title: "Task",
          description: "Description",
          dueDate: DateTime(2020, 1, 1),
          completed: false);

      final taskRepository = TaskRepository();

      final widget = MaterialApp(
          home: TaskDetailScreen(task: task, taskRepository: taskRepository));

      await tester.pumpWidget(widget);

      expect(find.image(const AssetImage('assets/images/ui_design.png')),
          findsOneWidget);
    });
    testWidgets('displays task title, date and description', (tester) async {
      final task = Task(
          title: "Task",
          description: "This is a description",
          dueDate: DateTime(2020, 1, 1),
          completed: false);

      final taskRepository = TaskRepository();

      final widget = MaterialApp(
          home: TaskDetailScreen(task: task, taskRepository: taskRepository));

      await tester.pumpWidget(widget);
      await tester.pump();

      expect(find.text('Task'), findsOneWidget);
      expect(find.text('This is a description'), findsOneWidget);
      expect(find.text('January 1, 2020'), findsOneWidget);
    });
  });
}
