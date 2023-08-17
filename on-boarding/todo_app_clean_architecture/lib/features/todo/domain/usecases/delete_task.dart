import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/task_repository.dart';
import '../entities/task.dart';

/// Use case for deleting a [Task]
///
/// Uses [TaskRepository] to delete a [Task]

class DeleteTask extends UseCase<Task, DeleteParams> {
  final TaskRepository _taskRepository;

  DeleteTask(this._taskRepository);

  @override
  Stream<Either<Failure, Task>> call(DeleteParams params) {
    return _taskRepository.deleteTask(params.id);
  }
}

/// Params for deleting a [Task]
///
/// Expects the task [id] to be deleted

class DeleteParams extends Equatable {
  final int id;

  const DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
