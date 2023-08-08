import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getTasks();
  Future<Either<Failure, Task>> getTask(String id);
  Future<Either<Failure, void>> createTask(Task todo);
  Future<Either<Failure, void>> updateTask(Task todo);
  Future<Either<Failure, void>> deleteTask(String id);
}
