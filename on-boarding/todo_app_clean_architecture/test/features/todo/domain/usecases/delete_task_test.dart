import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/repositories/task_repository.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/delete_task.dart';

import 'delete_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late MockTaskRepository mockTaskRepository;
  late DeleteTask usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = DeleteTask(mockTaskRepository);
  });

  const tTaskId = 1;
  final tTask = Task(
      id: 1,
      title: 'Task 1',
      description: 'Task 1 description',
      dueDate: DateTime(2019, 1, 1),
      completed: false);

  test('should delete task from repository', () async {
    when(mockTaskRepository.deleteTask(tTaskId)).thenAnswer((_) async* {
      yield Right(tTask);
    });

    final result = usecase(const DeleteParams(id: tTaskId));

    expect(result, emitsInOrder([Right(tTask)]));

    verify(mockTaskRepository.deleteTask(tTaskId));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
