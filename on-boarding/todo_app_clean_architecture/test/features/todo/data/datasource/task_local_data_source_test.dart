import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/core/error/exception.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_local_data_source.dart';
import 'package:todo_app_clean_architecture/features/todo/data/models/task_model.dart';

import '../../../../fixture/fixture_reader.dart';
import 'task_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late TaskLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        TaskLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  final tTask = TaskModel(
      id: '1',
      title: 'Task 1',
      description: 'Task 1 description',
      completed: true,
      dueDate: DateTime(2019, 1, 1));

  final tTaskUpdated = TaskModel(
      id: '1',
      title: 'Task 2',
      description: 'Task 2 description',
      completed: true,
      dueDate: DateTime(2019, 1, 1));

  final tTaskStore = [tTask];

  group('get tasks', () {
    test(
        'should return empty task list from SharedPreference when there is no task',
        () async {
      when(mockSharedPreferences.getString(sharedPreferenceStorageKey))
          .thenAnswer((_) => fixture('empty_task_store.json'));

      final result = await dataSource.getTasks();

      expect(result, isEmpty);

      verify(mockSharedPreferences.getString(sharedPreferenceStorageKey));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return task list from SharedPreferencee', () async {
      when(mockSharedPreferences.getString(sharedPreferenceStorageKey))
          .thenAnswer((_) => fixture('task_store.json'));

      final result = await dataSource.getTasks();

      expect(result, tTaskStore);

      verify(mockSharedPreferences.getString(sharedPreferenceStorageKey));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return task by id', () async {
      when(mockSharedPreferences.getString(sharedPreferenceStorageKey))
          .thenAnswer((_) => fixture('task_store.json'));

      final result = await dataSource.getTask(tTask.id);

      expect(result, tTask);

      verify(mockSharedPreferences.getString(sharedPreferenceStorageKey));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when task is not found', () async {
      when(mockSharedPreferences.getString(sharedPreferenceStorageKey))
          .thenAnswer((_) => fixture('task_store.json'));

      await expectLater(() async => await dataSource.getTask('2'),
          throwsA(isA<CacheException>()));

      verify(mockSharedPreferences.getString(sharedPreferenceStorageKey));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });

  group('create task', () {
    test('should call generate id and store task on SharedPreference',
        () async {
      when(mockSharedPreferences.getString(sharedPreferenceStorageKey))
          .thenAnswer((_) => fixture('empty_task_store.json'));

      when(mockSharedPreferences.setString(
              sharedPreferenceStorageKey, jsonEncode([tTask.toJson()])))
          .thenAnswer((_) async => true);

      await dataSource.createTask(tTask);

      verify(mockSharedPreferences.getString(sharedPreferenceStorageKey));
      verify(mockSharedPreferences.setString(
          sharedPreferenceStorageKey, jsonEncode([tTask.toJson()])));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });

  group('update task', () {
    test('should call getItem and setItem on SharedPreference', () async {
      when(mockSharedPreferences.getString(sharedPreferenceStorageKey))
          .thenAnswer((_) => fixture('task_store.json'));
      when(mockSharedPreferences.setString(
              sharedPreferenceStorageKey, jsonEncode([tTaskUpdated.toJson()])))
          .thenAnswer((_) async => true);

      await dataSource.updateTask(tTaskUpdated);

      verify(mockSharedPreferences.getString(sharedPreferenceStorageKey));
      verify(mockSharedPreferences.setString(
          sharedPreferenceStorageKey, jsonEncode([tTaskUpdated.toJson()])));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should raise CacheException if task is not found', () async {
      when(mockSharedPreferences.getString(sharedPreferenceStorageKey))
          .thenAnswer((_) => fixture('empty_task_store.json'));

      expect(
        () async => await dataSource.updateTask(tTaskUpdated),
        throwsA(isA<CacheException>()),
      );

      verify(mockSharedPreferences.getString(sharedPreferenceStorageKey));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });

  group('delete task', () {
    test('should call getItem and setItem on SharedPreference', () async {
      when(mockSharedPreferences.getString(sharedPreferenceStorageKey))
          .thenAnswer((_) => fixture('task_store.json'));
      when(mockSharedPreferences.setString(
              sharedPreferenceStorageKey, jsonEncode([])))
          .thenAnswer((_) async => true);

      await dataSource.deleteTask(tTask.id);

      verify(mockSharedPreferences.getString(sharedPreferenceStorageKey));
      verify(mockSharedPreferences.setString(
          sharedPreferenceStorageKey, jsonEncode([])));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}
