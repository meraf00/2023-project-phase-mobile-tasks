import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:todo_app_clean_architecture/core/error/failures.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_local_data_source.dart';
import 'package:todo_app_clean_architecture/features/todo/data/models/task_mapper.dart';
import 'package:todo_app_clean_architecture/features/todo/data/models/task_model.dart';
import 'package:todo_app_clean_architecture/features/todo/data/repositories/task_repository_impl.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';

import 'task_repository_impl_test.mocks.dart';

@GenerateMocks([TaskLocalDataSource])
void main() {
  late MockTaskLocalDataSource mockTaskLocalDataSource;
  late TaskRepositoryImpl taskRepositoryImpl;

  setUp(() {
    mockTaskLocalDataSource = MockTaskLocalDataSource();
    taskRepositoryImpl =
        TaskRepositoryImpl(localDataSource: mockTaskLocalDataSource);
  });

  const tTaskId = 1;
  final tTask = Task(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      dueDate: DateTime.now());
  final tTaskModel = TaskModel(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      dueDate: DateTime.now(),
      completed: false);

  test('should call get tasks from local data source', () async {
    when(mockTaskLocalDataSource.getTasks()).thenAnswer((_) async => []);

    await taskRepositoryImpl.getTasks();

    verify(mockTaskLocalDataSource.getTasks());
    verifyNoMoreInteractions(mockTaskLocalDataSource);
  });

  test('should call get task from local data source', () async {
    when(mockTaskLocalDataSource.getTask(tTaskId))
        .thenAnswer((_) async => tTaskModel);

    final result = await taskRepositoryImpl.getTask(tTaskId);

    expect(result, Right<Failure, Task>(tTask));

    verify(mockTaskLocalDataSource.getTask(tTaskId));
    verifyNoMoreInteractions(mockTaskLocalDataSource);
  });

  test('should call update tasks from local data source', () async {
    when(mockTaskLocalDataSource.updateTask(tTaskModel))
        .thenAnswer((_) async {});

    await taskRepositoryImpl.updateTask(tTask);

    verify(mockTaskLocalDataSource.updateTask(tTaskModel));
    verifyNoMoreInteractions(mockTaskLocalDataSource);
  });

  test('should call delete tasks from local data source', () async {
    when(mockTaskLocalDataSource.deleteTask(tTaskId))
        .thenAnswer((_) async => tTaskModel);

    await taskRepositoryImpl.deleteTask(tTaskId);

    verify(mockTaskLocalDataSource.deleteTask(tTaskId));
    verifyNoMoreInteractions(mockTaskLocalDataSource);
  });

  test('should call create tasks from local data source', () async {
    when(mockTaskLocalDataSource.createTask(tTaskModel))
        .thenAnswer((_) async => tTask.toModel());

    await taskRepositoryImpl.createTask(tTask);

    verify(mockTaskLocalDataSource.createTask(tTaskModel));
    verifyNoMoreInteractions(mockTaskLocalDataSource);
  });
}
