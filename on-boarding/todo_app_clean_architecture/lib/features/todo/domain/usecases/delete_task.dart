import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/task_repository.dart';
import '../entities/task.dart';

class DeleteTask extends UseCase<void, DeleteParams> {
  final TaskRepository _taskRepository;

  DeleteTask(this._taskRepository);

  @override
  Future<Either<Failure, Task>> call(DeleteParams params) async {
    return await _taskRepository.deleteTask(params.id);
  }
}

class DeleteParams extends Equatable {
  final int id;

  const DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
