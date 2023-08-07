import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/data/repositories/task_repository.dart';
import 'package:todo_app/todo/domain/entities/task.dart';
import 'package:todo_app/todo/presentation/screens/task_list.dart';
import 'package:todo_app/todo/presentation/widgets/button.dart';
import 'package:todo_app/todo/presentation/widgets/task_card.dart';

void main() {
  group("Test task list screen", () {
    testWidgets("displays image", (tester) async {
      final widget = MaterialApp(
          home: TaskListScreen(
        taskRepository: TaskRepository(),
      ));

      await tester.pumpWidget(widget);

      final image = find.image(const AssetImage("assets/images/task_list.png"));

      expect(image, findsOneWidget);
    });

    testWidgets("displays create task button", (tester) async {
      final widget = MaterialApp(
          home: TaskListScreen(
        taskRepository: TaskRepository(),
      ));

      await tester.pumpWidget(widget);

      final buttonFinder = find.byType(Button);

      final button = tester.firstWidget(buttonFinder) as Button;

      expect(buttonFinder, findsOneWidget);
      expect(button.label, "Create task");
    });

    testWidgets("displays tasks", (tester) async {
      final repository = TaskRepository();
      await repository.addTask(Task(
          completed: false,
          description: "Description 1",
          dueDate: DateTime(2020, 1, 1),
          title: "Task 1"));
      await repository.addTask(Task(
          completed: true,
          description: "Description 2",
          dueDate: DateTime(2020, 1, 1),
          title: "Task 2"));

      final widget = MaterialApp(
          home: TaskListScreen(
        taskRepository: repository,
      ));

      await tester.pumpWidget(widget);
      await tester.pump();

      final taskCardFinder = find.byType(TaskCard);

      expect(taskCardFinder, findsNWidgets(2));
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });
  });
}
