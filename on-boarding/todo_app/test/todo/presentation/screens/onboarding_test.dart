import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/presentation/screens/onboarding.dart';
import 'package:todo_app/todo/presentation/widgets/button.dart';

void main() {
  group("Test onboarding screen", () {
    testWidgets("displays image", (tester) async {
      const widget = MaterialApp(home: OnboardingScreen());

      await tester.pumpWidget(widget);

      final image =
          find.image(const AssetImage("assets/images/onboarding.jpg"));

      expect(image, findsOneWidget);
    });

    testWidgets("displays get started button", (tester) async {
      const widget = MaterialApp(home: OnboardingScreen());

      await tester.pumpWidget(widget);

      final buttonFinder = find.byType(Button);

      final button = tester.firstWidget(buttonFinder) as Button;

      expect(buttonFinder, findsOneWidget);
      expect(button.label, "Get started");
    });
  });
}
