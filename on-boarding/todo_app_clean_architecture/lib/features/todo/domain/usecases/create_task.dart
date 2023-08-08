import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CreateTask {
  final TaskRepository _taskRepository;

  CreateTask(this._taskRepository);

  Future<Either<Failure, void>> execute(Task task) async {
    return await _taskRepository.createTask(task);
  }
}
