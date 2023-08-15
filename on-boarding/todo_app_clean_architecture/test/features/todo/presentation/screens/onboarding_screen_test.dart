import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/core/network/network_info.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/screens/onboarding_screen.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/screens/task_list_screen.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/widgets.dart';
import 'package:todo_app_clean_architecture/injection_container.dart' as di;
import 'package:todo_app_clean_architecture/main.dart';

import 'onboarding_screen_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() async {
  // Mock InternetConnectionChecker to prevent Timer pending error
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    mockInternetConnectionChecker = MockInternetConnectionChecker();

    di.serviceLocator.allowReassignment = true;

    await di.init();

    di.serviceLocator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(mockInternetConnectionChecker));

    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) async => false);
  });

  group('Onboarding screen', () {
    testWidgets('should display background image', (tester) async {
      const widget = MaterialApp(home: OnboardingScreen());

      await tester.pumpWidget(widget);

      final image =
          find.image(const AssetImage('assets/images/onboarding.jpg'));

      expect(image, findsOneWidget);
    });

    testWidgets('should display get started button', (tester) async {
      const widget = MaterialApp(home: OnboardingScreen());

      await tester.pumpWidget(widget);

      final buttonFinder = find.byType(CustomButton);

      final button = tester.firstWidget(buttonFinder) as CustomButton;

      expect(buttonFinder, findsOneWidget);
      expect(button.label, 'Get started');
    });

    group('Navigation', () {
      testWidgets(
        'should navigate to tasks list screen when get started button is clicked',
        (tester) async {
          const widget = App();

          await tester.pumpWidget(widget);

          await tester.tap(find.text('Get started'));
          await tester.pumpAndSettle();

          expect(find.byType(TaskListScreen), findsOneWidget);
        },
      );
    });
  });
}
