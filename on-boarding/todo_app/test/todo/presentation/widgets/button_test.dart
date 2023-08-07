import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:todo_app/todo/presentation/widgets/button.dart";

void main() {
  group("Test button", () {
    testWidgets("displays correct label", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Button(onPressed: () {}, label: "Button"),
        ),
      );

      expect(find.text("Button"), findsOneWidget);
    });

    testWidgets("handles click event", (tester) async {
      var value = 0;

      final button = Button(
        onPressed: () {
          value++;
        },
        label: "Button",
      );

      final widget = MaterialApp(home: button);

      await tester.pumpWidget(widget);

      await tester.tap(find.byWidget(button));

      expect(value, 1);
    });
  });
}
