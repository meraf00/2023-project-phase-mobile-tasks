import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/core/network/network_info.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_local_data_source.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/custom_button.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/task_card.dart';
import 'package:todo_app_clean_architecture/injection_container.dart' as di;
import 'package:todo_app_clean_architecture/main.dart';

import 'task_list_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() async {
  // Mock InternetConnectionChecker to prevent Timer pending error
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();

    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) async => false);
  });

  group('Task list screen', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});

      di.serviceLocator.allowReassignment = true;

      await di.init();

      di.serviceLocator.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(mockInternetConnectionChecker));
    });

    testWidgets('should display image', (tester) async {
      await navigateToTaskList(tester);

      final image = find.image(const AssetImage('assets/images/task_list.png'));

      expect(image, findsOneWidget);
    });

    testWidgets('should display create task button', (tester) async {
      await navigateToTaskList(tester);

      final buttonFinder = find.byType(CustomButton);

      final button = tester.firstWidget(buttonFinder) as CustomButton;

      expect(buttonFinder, findsOneWidget);
      expect(button.label, 'Create task');
    });

    testWidgets('should display empty tasks message', (tester) async {
      await navigateToTaskList(tester);

      expect(find.text('No tasks found, why not add one?'), findsOneWidget);
    });

    tearDownAll(() {
      di.serviceLocator.reset(dispose: true);
    });
  });

  group('Task list screen', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({
        sharedPreferenceStorageKey:
            '[{"id":"1","title":"Task 1","description":"Task 1 description","dueDate":"2019-01-01T00:00:00.000","status":"Completed"},{"id":"2","title":"Task 2","description":"Task 2 description","dueDate":"2019-01-01T00:00:00.000","status":"Completed"}]'
      });

      di.serviceLocator.allowReassignment = true;

      await di.init();

      di.serviceLocator.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(mockInternetConnectionChecker));
    });

    testWidgets('should display tasks', (tester) async {
      await navigateToTaskList(tester);

      final taskCardFinder = find.byType(TaskCard);

      await expectLater(taskCardFinder, findsWidgets);

      expect(taskCardFinder, findsNWidgets(2));
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });

    tearDownAll(() {
      di.serviceLocator.reset(dispose: true);
    });
  });
}

Future<void> navigateToTaskList(tester) async {
  const widget = App();

  await tester.pumpWidget(widget);

  await tester.tap(find.text('Get started'));
  await tester.pumpAndSettle();
}
