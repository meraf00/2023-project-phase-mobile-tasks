import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class ViewTask extends UseCase<Task, GetTaskParams> {
  final TaskRepository _taskRepository;

  ViewTask(this._taskRepository);

  @override
  Future<Either<Failure, Task>> call(GetTaskParams params) async {
    return await _taskRepository.getTask(params.id);
  }
}

class GetTaskParams extends Equatable {
  final int id;

  const GetTaskParams({required this.id});

  @override
  List<Object?> get props => [id];
}
