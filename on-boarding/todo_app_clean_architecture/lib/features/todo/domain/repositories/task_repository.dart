import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

/// Repository contract for [Task]

abstract class TaskRepository {
  Stream<Either<Failure, List<Task>>> getTasks();
  Stream<Either<Failure, Task>> getTask(int id);
  Stream<Either<Failure, Task>> createTask(Task task);
  Stream<Either<Failure, Task>> updateTask(Task task);
  Stream<Either<Failure, Task>> deleteTask(int id);
}
