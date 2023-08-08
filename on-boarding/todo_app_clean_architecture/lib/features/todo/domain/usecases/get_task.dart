import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTask extends UseCase<Task, Params> {
  final TaskRepository _taskRepository;

  GetTask(this._taskRepository);

  @override
  Future<Either<Failure, Task>> call(Params params) async {
    return await _taskRepository.getTask(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
