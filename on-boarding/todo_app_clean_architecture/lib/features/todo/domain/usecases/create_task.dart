import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CreateTask extends UseCase<void, CreateParams> {
  final TaskRepository _taskRepository;

  CreateTask(this._taskRepository);

  @override
  Future<Either<Failure, Task>> call(CreateParams params) async {
    return await _taskRepository.createTask(params.task);
  }
}

class CreateParams extends Equatable {
  final Task task;

  const CreateParams({required this.task});

  @override
  List<Object?> get props => [task];
}