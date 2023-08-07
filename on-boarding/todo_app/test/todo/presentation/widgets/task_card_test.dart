import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/presentation/widgets/task_card.dart';

void main() {
  group("Test task card", () {
    testWidgets("displays correct title and date format", (tester) async {
      final date = DateTime(2020, 1, 1);

      final card =
          TaskCard(title: "Task title", deadline: date, completed: true);

      final widget = MaterialApp(home: card);

      await tester.pumpWidget(widget);

      expect(find.text("Task title"), findsOneWidget);
      expect(find.text("January 1, 2020"), findsOneWidget);
    });

    testWidgets("displays green color for completed task", (tester) async {
      final date = DateTime(2020, 1, 1);

      final card =
          TaskCard(title: "Task title", deadline: date, completed: true);

      final widget = MaterialApp(home: card);

      await tester.pumpWidget(widget);

      final divider =
          tester.firstWidget(find.byType(VerticalDivider)) as VerticalDivider;

      expect(divider.color, Colors.green);
    });

    testWidgets("displays red color for pending task", (tester) async {
      final date = DateTime(2020, 1, 1);

      final card =
          TaskCard(title: "Task title", deadline: date, completed: false);

      final widget = MaterialApp(home: card);

      await tester.pumpWidget(widget);

      final divider =
          tester.firstWidget(find.byType(VerticalDivider)) as VerticalDivider;

      expect(divider.color, Colors.red);
    });
  });
}
