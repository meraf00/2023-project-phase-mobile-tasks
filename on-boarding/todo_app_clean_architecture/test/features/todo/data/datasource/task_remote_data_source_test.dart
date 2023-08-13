import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/core/error/exception.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_remote_data_source.dart';
import 'package:todo_app_clean_architecture/core/constants/constants.dart';
import 'package:todo_app_clean_architecture/features/todo/data/models/task_model.dart';

import '../../../../fixture/fixture_reader.dart';
import 'task_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late TaskRemoteDataSource remoteDataSource;

  setUp(() {
    mockClient = MockClient();
    remoteDataSource = TaskRemoteDataSourceImpl(client: mockClient);
  });

  const getAllTasksApiUrl = '$apiBaseUrl/task';
  const getTaskApiUrl = '$apiBaseUrl/task/1';
  const createTaskApiUrl = '$apiBaseUrl/task';
  const updateTaskApiUrl = '$apiBaseUrl/task/1';
  const deleteTaskApiUrl = '$apiBaseUrl/task/1';

  const tTaskId = 1;

  final tTaskModel = TaskModel(
    id: 1,
    title: 'Task 1',
    description: 'Task 1 description',
    dueDate: DateTime(2019, 1, 1),
    completed: true,
  );

  final tTaskModels = [tTaskModel];

  group('getTasks', () {
    test(
        'should perform GET request to $getAllTasksApiUrl with header application/json header',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_store.json'), 200));

      await remoteDataSource.getTasks();

      verify(mockClient.get(
        Uri.parse(getAllTasksApiUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockClient);
    });

    test(
        'should return list of TaskModel when the response code is 200 (success)',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_store.json'), 200));

      final result = await remoteDataSource.getTasks();

      expect(result, isA<List<TaskModel>>());
      expect(result, tTaskModels);

      verify(mockClient.get(
        Uri.parse(getAllTasksApiUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockClient);
    });

    test('should throw exception when the response code is not 200 (success)',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_store.json'), 404));

      expect(() async => await remoteDataSource.getTasks(),
          throwsA(isA<ServerException>()));

      verify(mockClient.get(
        Uri.parse(getAllTasksApiUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockClient);
    });
  });

  group('getTask', () {
    test(
        'should perform GET request to $getTaskApiUrl with header application/json header',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_model.json'), 200));

      await remoteDataSource.getTask(tTaskId);

      verify(mockClient.get(
        Uri.parse(getTaskApiUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockClient);
    });

    test('should return TaskModel when the response code is 200 (success)',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_model.json'), 200));

      final result = await remoteDataSource.getTask(tTaskId);

      expect(result, isA<TaskModel>());
      expect(result, tTaskModel);

      verify(mockClient.get(
        Uri.parse(getTaskApiUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockClient);
    });

    test('should throw exception when the response code is not 200 (success)',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_model.json'), 404));

      expect(() async => await remoteDataSource.getTask(tTaskId),
          throwsA(isA<ServerException>()));

      verify(mockClient.get(
        Uri.parse(getTaskApiUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockClient);
    });
  });

  group('createTask', () {
    test(
        'should perform POST request to $createTaskApiUrl with header application/json header',
        () async {
      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
              (_) async => http.Response(fixture('task_model.json'), 201));

      await remoteDataSource.createTask(tTaskModel);

      verify(mockClient.post(Uri.parse(createTaskApiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(tTaskModel.toJson())));
      verifyNoMoreInteractions(mockClient);
    });

    test('should return TaskModel when the response code is 201 (created)',
        () async {
      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
              (_) async => http.Response(fixture('task_model.json'), 201));

      final result = await remoteDataSource.createTask(tTaskModel);

      expect(result, tTaskModel);

      verify(mockClient.post(Uri.parse(createTaskApiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(tTaskModel.toJson())));
      verifyNoMoreInteractions(mockClient);
    });

    test('should throw exception when the response code is not 201 (created)',
        () async {
      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Server error', 500));

      expect(() async => await remoteDataSource.createTask(tTaskModel),
          throwsA(isA<ServerException>()));

      verify(mockClient.post(Uri.parse(createTaskApiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(tTaskModel.toJson())));
      verifyNoMoreInteractions(mockClient);
    });
  });

  group('updateTask', () {
    test(
        'should perform PUT request to $updateTaskApiUrl with header application/json header',
        () async {
      when(mockClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
              (_) async => http.Response(fixture('task_model.json'), 200));

      await remoteDataSource.updateTask(tTaskModel);

      verify(mockClient.put(Uri.parse(createTaskApiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(tTaskModel.toJson())));
      verifyNoMoreInteractions(mockClient);
    });

    test('should throw exception when the response code is not 200 (success)',
        () async {
      when(mockClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Server error', 500));

      expect(() async => await remoteDataSource.updateTask(tTaskModel),
          throwsA(isA<ServerException>()));

      verify(mockClient.put(Uri.parse(createTaskApiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(tTaskModel.toJson())));
      verifyNoMoreInteractions(mockClient);
    });
  });

  group('deleteTask', () {
    test(
        'should perform DELETE request to $deleteTaskApiUrl with header application/json header',
        () async {
      when(mockClient.delete(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_model.json'), 200));

      await remoteDataSource.deleteTask(tTaskId);

      verify(mockClient.delete(
        Uri.parse(deleteTaskApiUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockClient);
    });

    test('should throw exception when the response code is not 200 (success)',
        () async {
      when(mockClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Server error', 500));

      expect(() async => await remoteDataSource.deleteTask(tTaskId),
          throwsA(isA<ServerException>()));

      verify(mockClient.delete(
        Uri.parse(deleteTaskApiUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockClient);
    });
  });
}
