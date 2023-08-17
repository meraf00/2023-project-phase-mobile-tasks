import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Use case for updating a [Task]
///
/// Uses [TaskRepository] to update a [Task]

class UpdateTask extends UseCase<Task, UpdateParams> {
  final TaskRepository _taskRepository;

  UpdateTask(this._taskRepository);

  @override
  Stream<Either<Failure, Task>> call(UpdateParams params) {
    return _taskRepository.updateTask(params.task);
  }
}

/// Params for updating a [Task]
///
/// Expects the [Task] to be updated

class UpdateParams extends Equatable {
  final Task task;

  const UpdateParams({required this.task});

  @override
  List<Object?> get props => [task];
}
