import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getTasks();
  Future<Either<Failure, Task>> getTask(int id);
  Future<Either<Failure, Task>> createTask(Task task);
  Future<Either<Failure, void>> updateTask(Task task);
  Future<Either<Failure, Task>> deleteTask(int id);
}
