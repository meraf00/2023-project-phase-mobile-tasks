import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/task_repository.dart';

class DeleteTask extends UseCase<void, Params> {
  final TaskRepository _taskRepository;

  DeleteTask(this._taskRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _taskRepository.deleteTask(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
