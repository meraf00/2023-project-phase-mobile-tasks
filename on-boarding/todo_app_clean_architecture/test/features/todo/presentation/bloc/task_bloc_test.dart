import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/core/error/failures.dart';
import 'package:todo_app_clean_architecture/core/presentation/messages.dart';
import 'package:todo_app_clean_architecture/core/presentation/util/input_converter.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/usecases.dart'
    as usecases;
import 'package:todo_app_clean_architecture/features/todo/presentation/bloc/task_bloc.dart';

import 'task_bloc_test.mocks.dart';

@GenerateMocks([
  InputConverter,
  usecases.GetAllTasks,
  usecases.GetTask,
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

  const tTaskId = '1';

  final tDate = DateTime(2020, 1, 1);

  const tDateString = '2020-01-01';

  final tTask = Task(
    id: '1',
    title: 'Task 1',
    description: 'Task description',
    dueDate: DateTime(2020, 1, 1),
    completed: false,
  );

  group('Task bloc', () {
    test('initial state should be TaskInitial', () {
      expect(taskBloc.state, equals(InitialState()));
    });

    blocTest<TaskBloc, TaskState>(
      'should emit TaskLoading, TasksLoaded states for GetAllTasks',
      build: () => taskBloc,
      act: (bloc) {
        when(mockGetAllTasks(any)).thenAnswer((_) async* {
          yield const Right([]);
        });

        bloc.add(LoadAllTasksEvent());
      },
      expect: () => [
        LoadingState(),
        const LoadedAllTasksState([]),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'should emit TaskLoading, TaskLoaded for GetTask',
      build: () => taskBloc,
      act: (bloc) {
        when(mockGetTask(any)).thenAnswer((_) async* {
          yield Right(tTask);
        });

        bloc.add(const GetSingleTaskEvent(tTaskId));
      },
      expect: () => [
        LoadingState(),
        LoadedSingleTaskState(tTask),
      ],
    );

    // create task
    blocTest<TaskBloc, TaskState>(
      'should emit TaskCreated when new task is created',
      build: () => taskBloc,
      act: (bloc) {
        when(mockCreateTask(any)).thenAnswer((_) async* {
          yield Right(tTask);
        });
        when(mockInputConverter.stringToDateTime(any, future: true))
            .thenAnswer((_) => Right(tDate));

        bloc.add(CreateTaskEvent(tTask.title, tTask.description, tDateString));
      },
      expect: () => [
        CreatedTaskState(tTask),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'should emit TaskError for when task creation fails',
      build: () => taskBloc,
      act: (bloc) {
        when(mockInputConverter.stringToDateTime(any, future: true))
            .thenAnswer((_) => Left(InvalidInputFailure.invalidDate()));

        bloc.add(CreateTaskEvent(tTask.title, tTask.description, tDateString));

        verifyNoMoreInteractions(mockCreateTask);
      },
      expect: () => [
        const ErrorState(invalidDateFailureMessage),
      ],
    );

    // update task
    blocTest<TaskBloc, TaskState>(
      'should emit TaskUpdated for on successful task update',
      build: () => taskBloc,
      act: (bloc) {
        when(mockUpdateTask(any)).thenAnswer((_) async* {
          yield Right(tTask);
        });
        when(mockInputConverter.stringToDateTime(any, future: true))
            .thenAnswer((_) => Right(DateTime(2020, 1, 1)));

        bloc.add(UpdateTaskEvent(tTask.id, tTask.title, tTask.description,
            tDateString, tTask.completed));
      },
      expect: () => [
        UpdatedTaskState(tTask),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'should emit TaskError for when task update fails',
      build: () => taskBloc,
      act: (bloc) {
        when(mockInputConverter.stringToDateTime(any, future: true))
            .thenAnswer((_) => Left(InvalidInputFailure.invalidDate()));

        bloc.add(UpdateTaskEvent(tTask.id, tTask.title, tTask.description,
            tDateString, tTask.completed));

        verifyNoMoreInteractions(mockUpdateTask);
      },
      expect: () => [
        const ErrorState(invalidDateFailureMessage),
      ],
    );

    // delete task
    blocTest<TaskBloc, TaskState>(
      'should emit TaskDelete on successful task delete',
      build: () => taskBloc,
      act: (bloc) {
        when(mockDeleteTask(any)).thenAnswer((_) async* {
          yield Right(tTask);
        });

        bloc.add(DeleteTaskEvent(tTask.id));
      },
      expect: () => [
        DeletedTaskState(tTask),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'should emit TaskError for when task delete fails',
      build: () => taskBloc,
      act: (bloc) {
        when(mockDeleteTask(any)).thenAnswer((_) async* {
          yield Left(CacheFailure.cacheNotFound());
        });

        bloc.add(DeleteTaskEvent(tTask.id));

        verifyNoMoreInteractions(mockUpdateTask);
      },
      expect: () => [
        const ErrorState(cacheMissFailureMessage),
      ],
    );
  });
}
