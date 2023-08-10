import 'package:dartz/dartz.dart' hide Task;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/core/error/failures.dart';

import 'package:todo_app_clean_architecture/core/presentation/util/input_converter.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/usecases.dart'
    as usecases;

import 'task_bloc_test.mocks.dart';

@GenerateMocks([
  InputConverter,
  usecases.ViewAllTasks,
  usecases.ViewTask,
  usecases.CreateTask,
  usecases.UpdateTask,
  usecases.DeleteTask
])
void main() {
  late TaskBloc taskBloc;
  late MockInputConverter mockInputConverter;
  late MockGetAllTasks mockGetAllTasks;
  late MockGetTask mockGetTask;
  late MockCreateTask mockCreateTask;
  late MockUpdateTask mockUpdateTask;
  late MockDeleteTask mockDeleteTask;

  setUp(() {
    mockInputConverter = MockInputConverter();

    mockGetAllTasks = MockGetAllTasks();
    mockGetTask = MockGetTask();
    mockCreateTask = MockCreateTask();
    mockUpdateTask = MockUpdateTask();
    mockDeleteTask = MockDeleteTask();

    taskBloc = TaskBloc(
      createTask: mockCreateTask,
      deleteTask: mockDeleteTask,
      updateTask: mockUpdateTask,
      getTask: mockGetTask,
      getAllTasks: mockGetAllTasks,
      inputConverter: mockInputConverter,
    );
  });

  const tTaskId = 1;

  final tDate = DateTime(2020, 1, 1);

  const tDateString = '2020-01-01';

  final tTask = Task(
    id: 1,
    title: 'Task 1',
    description: 'Task description',
    dueDate: DateTime(2020, 1, 1),
    completed: false,
  );

  group('Task bloc', () {
    test('initial state should be TaskInitial', () {
      expect(taskBloc.state, equals(TaskInitial()));
    });

    blocTest<TaskBloc, TaskState>(
      'should emit TaskLoading, TasksLoaded states for GetAllTasks',
      build: () => taskBloc,
      act: (bloc) {
        when(mockGetAllTasks(any)).thenAnswer((_) async => const Right([]));

        bloc.add(GetTasks());
      },
      expect: () => [
        TaskLoading(),
        const TasksLoaded([]),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'should emit TaskLoading, TaskLoaded for GetTask',
      build: () => taskBloc,
      act: (bloc) {
        when(mockGetTask(any)).thenAnswer((_) async => Right(tTask));

        bloc.add(const GetTask(tTaskId));
      },
      expect: () => [
        TaskLoading(),
        TaskLoaded(tTask),
      ],
    );

    // create task
    blocTest<TaskBloc, TaskState>(
      'should emit TaskCreated when new task is created',
      build: () => taskBloc,
      act: (bloc) {
        when(mockCreateTask(any)).thenAnswer((_) async => Right(tTask));
        when(mockInputConverter.stringToDateTime(any))
            .thenAnswer((_) => Right(tDate));

        bloc.add(CreateTask(tTask.title, tTask.description, tDateString));
      },
      expect: () => [
        TaskCreated(tTask),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'should emit TaskError for when task creation fails',
      build: () => taskBloc,
      act: (bloc) {
        when(mockInputConverter.stringToDateTime(any))
            .thenAnswer((_) => Left(InvalidInputFailure()));

        bloc.add(CreateTask(tTask.title, tTask.description, tDateString));

        verifyNoMoreInteractions(mockCreateTask);
      },
      expect: () => [
        const TaskError(invalidDateFailureMessage),
      ],
    );

    // update task
    blocTest<TaskBloc, TaskState>(
      'should emit TaskUpdated for on successful task update',
      build: () => taskBloc,
      act: (bloc) {
        when(mockUpdateTask(any)).thenAnswer((_) async => const Right(null));
        when(mockInputConverter.stringToDateTime(any))
            .thenAnswer((_) => Right(DateTime(2020, 1, 1)));

        bloc.add(UpdateTask(tTask.id, tTask.title, tTask.description,
            tDateString, tTask.completed));
      },
      expect: () => [
        TaskUpdated(tTask),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'should emit TaskError for when task update fails',
      build: () => taskBloc,
      act: (bloc) {
        when(mockInputConverter.stringToDateTime(any))
            .thenAnswer((_) => Left(InvalidInputFailure()));

        bloc.add(UpdateTask(tTask.id, tTask.title, tTask.description,
            tDateString, tTask.completed));

        verifyNoMoreInteractions(mockUpdateTask);
      },
      expect: () => [
        const TaskError(invalidDateFailureMessage),
      ],
    );

    // delete task
    blocTest<TaskBloc, TaskState>(
      'should emit TaskDelete on successful task delete',
      build: () => taskBloc,
      act: (bloc) {
        when(mockDeleteTask(any)).thenAnswer((_) async => Right(tTask));

        bloc.add(DeleteTask(tTask.id));
      },
      expect: () => [
        TaskDeleted(tTask),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'should emit TaskError for when task delete fails',
      build: () => taskBloc,
      act: (bloc) {
        when(mockDeleteTask(any)).thenAnswer(
            (_) async => Left(CacheFailure(message: cacheFailureMessage)));

        bloc.add(DeleteTask(tTask.id));

        verifyNoMoreInteractions(mockUpdateTask);
      },
      expect: () => [
        const TaskError(cacheFailureMessage),
      ],
    );
  });
}
