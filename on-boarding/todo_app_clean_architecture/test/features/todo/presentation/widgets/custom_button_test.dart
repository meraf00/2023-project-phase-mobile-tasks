import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/custom_button.dart';

class Functions {
  void call() {}
}

class MockFunction extends Mock implements Functions {}

void main() {
  late MockFunction mockFunction;

  setUp(() {
    mockFunction = MockFunction();
  });

  group('Test button', () {
    testWidgets('displays correct label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomButton(onPressed: mockFunction, label: 'Button'),
        ),
      );

      expect(find.text('Button'), findsOneWidget);
    });

    testWidgets('handles click event', (tester) async {
      final button = CustomButton(
        onPressed: mockFunction,
        label: 'Button',
      );

      final widget = MaterialApp(home: button);

      await tester.pumpWidget(widget);

      await tester.tap(find.byWidget(button));

      verify(mockFunction.call());
    });
  });
}
