import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/main.dart';
import 'package:todo_app/todo/data/repositories/task_repository.dart';
import 'package:todo_app/todo/presentation/screens/add_task.dart';
import 'package:todo_app/todo/presentation/screens/task_list.dart';
import 'package:todo_app/todo/presentation/widgets/task_card.dart';

void main() {
  group('Add task screen', () {
    testWidgets(
      'adds task and updates task list when user input is valid',
      (WidgetTester tester) async {
        final repository = TaskRepository();

        await tester.pumpWidget(App(
          taskRepository: repository,
        ));

        await tester.pump();

        // navigate to task list screen when get started is clicked
        await tester.tap(find.text('Get started'));
        await tester.pumpAndSettle();

        // verify task list screen is displayed
        expect(find.byType(TaskListScreen), findsOneWidget);

        // navigate to add task screen
        await tester.tap(find.text('Create task'));
        await tester.pumpAndSettle();

        // verify add task screen is displayed
        expect(find.byType(AddTaskScreen), findsOneWidget);

        // enter task details
        final inputFields = tester.widgetList(find.byType(TextField)).toList();

        await tester.enterText(find.byWidget(inputFields[0]), "Task 1");
        await tester.enterText(find.byWidget(inputFields[1]), "2020-01-01");
        await tester.enterText(
            find.byWidget(inputFields[2]), "This is test description.");

        // tap on add task button
        await tester.tap(find.text('Add task'));
        await tester.pumpAndSettle();

        // verify new task is isplayed
        expect(find.byType(TaskCard), findsOneWidget);
        expect(find.text('Task 1'), findsOneWidget);
        expect(find.text('January 1, 2020'), findsOneWidget);
      },
    );

    testWidgets(
      'displays snackbar on invalid input',
      (WidgetTester tester) async {
        final repository = TaskRepository();

        await tester.pumpWidget(App(
          taskRepository: repository,
        ));

        await tester.pump();

        // navigate to task list screen when get started is clicked
        await tester.tap(find.text('Get started'));
        await tester.pumpAndSettle();

        // verify task list screen is displayed
        expect(find.byType(TaskListScreen), findsOneWidget);

        // navigate to add task screen
        await tester.tap(find.text('Create task'));
        await tester.pumpAndSettle();

        // verify add task screen is displayed
        expect(find.byType(AddTaskScreen), findsOneWidget);

        // tap add task with empty fields
        await tester.tap(find.text('Add task'));
        await tester.pump();

        expect(find.text('Invalid date format'), findsOneWidget);
      },
    );
  });

  testWidgets(
    'Onboarding screen navigates to todo list screen',
    (tester) async {
      final repository = TaskRepository();

      await tester.pumpWidget(App(
        taskRepository: repository,
      ));

      await tester.pump();

      // navigate to task list screen when get started is clicked
      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();

      // verify task list screen is displayed
      expect(find.byType(TaskListScreen), findsOneWidget);
    },
  );
}
