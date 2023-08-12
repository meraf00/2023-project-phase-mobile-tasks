import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/core/network/network_info.dart';
import 'package:todo_app_clean_architecture/injection_container.dart' as di;
import 'package:todo_app_clean_architecture/main.dart';

import 'create_task_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() async {
  // Mock InternetConnectionChecker to prevent Timer pending error
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();

    di.serviceLocator.allowReassignment = true;
    di.serviceLocator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(mockInternetConnectionChecker));

    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) async => false);
  });

  group('Task create screen', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await di.init();
    });

    testWidgets('contains three text fields', (tester) async {
      await navigateToCreateTask(tester);
      expect(find.byType(TextFormField), findsNWidgets(3));
    });

    testWidgets('display validation failure on empty input', (tester) async {
      await navigateToCreateTask(tester);

      await tester.tap(find.text("Add task"));
      await tester.pumpAndSettle();

      expect(find.text("Please enter a title"), findsOneWidget);
    });

    tearDownAll(() {
      di.serviceLocator.reset(dispose: true);
    });
  });
}

Future<void> navigateToCreateTask(tester) async {
  const widget = App();

  await tester.pumpWidget(widget);

  await tester.tap(find.text("Get started"));
  await tester.pumpAndSettle();

  await tester.tap(find.text("Create task"));
  await tester.pumpAndSettle();
}
