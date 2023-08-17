import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/core/error/failures.dart';
import 'package:todo_app_clean_architecture/core/network/network_info.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_local_data_source.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_remote_data_source.dart';
import 'package:todo_app_clean_architecture/features/todo/data/models/task_model.dart';
import 'package:todo_app_clean_architecture/features/todo/data/repositories/task_repository_impl.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';

import 'task_repository_impl_test.mocks.dart';

@GenerateMocks([
  TaskLocalDataSource,
  TaskRemoteDataSource,
  NetworkInfo,
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockTaskLocalDataSource mockTaskLocalDataSource;
  late MockTaskRemoteDataSource mockTaskRemoteDataSource;
  late TaskRepositoryImpl taskRepositoryImpl;

  setUp(() {
    mockTaskLocalDataSource = MockTaskLocalDataSource();
    mockTaskRemoteDataSource = MockTaskRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    taskRepositoryImpl = TaskRepositoryImpl(
        localDataSource: mockTaskLocalDataSource,
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockTaskRemoteDataSource);
  });

  const tTaskId = '1';
  final tTask = Task(
      id: '1',
      title: 'Test Task',
      description: 'Test Description',
      dueDate: DateTime(2020, 1, 1));
  final tTaskModel = TaskModel(
      id: '1',
      title: 'Test Task',
      description: 'Test Description',
      dueDate: DateTime(2020, 1, 1),
      completed: false);

  group('when connected', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should call get tasks from local and remote data source', () async {
      when(mockTaskLocalDataSource.getTasks()).thenAnswer((_) async => []);
      when(mockTaskRemoteDataSource.getTasks()).thenAnswer((_) async => []);

      final stream = taskRepositoryImpl.getTasks();

      expect(await stream.elementAt(0), isA<Right<Failure, List<Task>>>());

      verify(mockTaskLocalDataSource.getTasks());
      verify(mockTaskRemoteDataSource.getTasks());
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });

    test('should call get task from local and remote data source', () async {
      when(mockTaskLocalDataSource.getTask(tTaskId))
          .thenAnswer((_) async => tTaskModel);
      when(mockTaskRemoteDataSource.getTask(tTaskId))
          .thenAnswer((_) async => tTaskModel);

      final result = taskRepositoryImpl.getTask(tTaskId);

      await expectLater(result, emits(Right<Failure, Task>(tTask)));

      verify(mockTaskLocalDataSource.getTask(tTaskId));
      verify(mockTaskRemoteDataSource.getTask(tTaskId));
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });

    test('should call update tasks from local and remote data source',
        () async {
      when(mockTaskLocalDataSource.updateTask(tTaskModel))
          .thenAnswer((_) async => tTaskModel);
      when(mockTaskRemoteDataSource.updateTask(tTaskModel))
          .thenAnswer((_) async => tTaskModel);

      final stream = taskRepositoryImpl.updateTask(tTask);

      await expectLater(stream, emits(Right(tTask)));

      verify(mockTaskLocalDataSource.updateTask(tTaskModel));
      verify(mockTaskRemoteDataSource.updateTask(tTaskModel));
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });

    test('should call delete tasks from local and remote data source',
        () async {
      when(mockTaskLocalDataSource.deleteTask(tTaskId))
          .thenAnswer((_) async => tTaskModel);
      when(mockTaskRemoteDataSource.deleteTask(tTaskId))
          .thenAnswer((_) async => tTaskModel);

      final stream = taskRepositoryImpl.deleteTask(tTaskId);

      await expectLater(stream, emits(Right(tTask)));

      verify(mockTaskLocalDataSource.deleteTask(tTaskId));
      verify(mockTaskRemoteDataSource.deleteTask(tTaskId));
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });

    test('should call create tasks from local and remote data source',
        () async {
      when(mockTaskLocalDataSource.createTask(tTaskModel))
          .thenAnswer((_) async => tTask.toModel());
      when(mockTaskRemoteDataSource.createTask(tTaskModel))
          .thenAnswer((_) async => tTaskModel);

      final stream = taskRepositoryImpl.createTask(tTask);

      await expectLater(stream, emits(Right(tTask)));

      verify(mockTaskLocalDataSource.createTask(tTaskModel));
      verify(mockTaskRemoteDataSource.createTask(tTaskModel));
      verifyNoMoreInteractions(mockTaskLocalDataSource);
    });
  });

  group('when connection is not available', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test('should call get task from only from local data source', () async {
      when(mockTaskLocalDataSource.getTask(tTaskId))
          .thenAnswer((_) async => tTaskModel);

      final result = taskRepositoryImpl.getTask(tTaskId);

      await expectLater(result, emits(Right<Failure, Task>(tTask)));

      verify(mockTaskLocalDataSource.getTask(tTaskId));
      verifyNever(mockTaskRemoteDataSource.getTask(tTaskId));
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });

    test('should call get tasks from only from local data source', () async {
      when(mockTaskLocalDataSource.getTasks()).thenAnswer((_) async => []);

      final stream = taskRepositoryImpl.getTasks();

      expect(await stream.elementAt(0), isA<Right<Failure, List<Task>>>());

      verify(mockTaskLocalDataSource.getTasks());
      verifyNever(mockTaskRemoteDataSource.getTasks());
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });

    test('should not update tasks', () async {
      when(mockTaskLocalDataSource.updateTask(tTaskModel))
          .thenAnswer((_) async => tTaskModel);

      final stream = taskRepositoryImpl.updateTask(tTask);

      await expectLater(stream, emits(Left(ServerFailure.connectionFailed())));

      verifyNever(mockTaskLocalDataSource.updateTask(tTaskModel));
      verifyNever(mockTaskRemoteDataSource.updateTask(tTaskModel));
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });

    test('should not delete task', () async {
      when(mockTaskLocalDataSource.deleteTask(tTaskId))
          .thenAnswer((_) async => tTaskModel);

      final stream = taskRepositoryImpl.deleteTask(tTaskId);

      await expectLater(stream, emits(Left(ServerFailure.connectionFailed())));

      verifyNever(mockTaskLocalDataSource.deleteTask(tTaskId));
      verifyNever(mockTaskRemoteDataSource.deleteTask(tTaskId));
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });

    test('should not create task', () async {
      when(mockTaskLocalDataSource.createTask(tTaskModel))
          .thenAnswer((_) async => tTask.toModel());

      final stream = taskRepositoryImpl.createTask(tTask);

      await expectLater(stream, emits(Left(ServerFailure.connectionFailed())));

      verifyNever(mockTaskLocalDataSource.createTask(tTaskModel));
      verifyNever(mockTaskRemoteDataSource.createTask(tTaskModel));
      verifyNoMoreInteractions(mockTaskLocalDataSource);
      verifyNoMoreInteractions(mockTaskRemoteDataSource);
    });
  });
}
