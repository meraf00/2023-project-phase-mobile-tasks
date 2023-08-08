import 'package:dartz/dartz.dart' hide Task;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/repositories/task_repository.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/create_task.dart';

import 'create_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late CreateTask usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = CreateTask(mockTaskRepository);
  });

  final tTask = Task(
    id: -1,
    title: 'Test Task',
    description: 'Test Description',
    dueDate: DateTime.now(),
  );

  test('should create new task and add it to repository', () async {
    when(mockTaskRepository.createTask(tTask))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(Params(task: tTask));

    expect(result, const Right(null));

    verify(mockTaskRepository.createTask(tTask));

    verifyNoMoreInteractions(mockTaskRepository);
  });
}
