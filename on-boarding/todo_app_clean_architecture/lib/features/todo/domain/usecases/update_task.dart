import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTask extends UseCase<void, UpdateParams> {
  final TaskRepository _taskRepository;

  UpdateTask(this._taskRepository);

  @override
  Future<Either<Failure, void>> call(UpdateParams params) async {
    return await _taskRepository.updateTask(params.task);
  }
}

class UpdateParams extends Equatable {
  final Task task;

  const UpdateParams({required this.task});

  @override
  List<Object?> get props => [task];
}
