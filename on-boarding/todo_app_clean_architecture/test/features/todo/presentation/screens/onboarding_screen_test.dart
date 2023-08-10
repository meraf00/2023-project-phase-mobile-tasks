import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/screens/onboarding_screen.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/screens/task_list_screen.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/widgets.dart';
import 'package:todo_app_clean_architecture/main.dart';
import 'package:todo_app_clean_architecture/injection_container.dart';

void main() {
  group("Onboarding screen", () {
    testWidgets("should display background image", (tester) async {
      const widget = MaterialApp(home: OnboardingScreen());

      await tester.pumpWidget(widget);

      final image =
          find.image(const AssetImage("assets/images/onboarding.jpg"));

      expect(image, findsOneWidget);
    });

    testWidgets("should display get started button", (tester) async {
      const widget = MaterialApp(home: OnboardingScreen());

      await tester.pumpWidget(widget);

      final buttonFinder = find.byType(CustomButton);

      final button = tester.firstWidget(buttonFinder) as CustomButton;

      expect(buttonFinder, findsOneWidget);
      expect(button.label, "Get started");
    });

    group('Navigation', () {
      setUp(() async {
        SharedPreferences.setMockInitialValues(<String, Object>{});

        await init();
      });

      testWidgets(
        "should navigate to tasks list screen when get started button is clicked",
        (tester) async {
          const widget = App();

          await tester.pumpWidget(widget);

          await tester.tap(find.text("Get started"));
          await tester.pumpAndSettle();

          expect(find.byType(TaskListScreen), findsOneWidget);
        },
      );
    });
  });
}
