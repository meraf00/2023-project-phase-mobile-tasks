import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/repositories/task_repository.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/update_task.dart';

import 'update_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late MockTaskRepository mockTaskRepository;
  late UpdateTask usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = UpdateTask(mockTaskRepository);
  });

  final tTask = Task(
    id: 1,
    title: 'Test Task',
    description: 'Test Description',
    dueDate: DateTime(2020, 1, 1),
  );

  test('should update task from repository', () async {
    when(mockTaskRepository.updateTask(tTask)).thenAnswer((_) async* {
      yield Right(tTask);
    });

    final result = usecase(UpdateParams(task: tTask));

    expect(result, emitsInOrder([Right(tTask)]));

    verify(mockTaskRepository.updateTask(tTask));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
