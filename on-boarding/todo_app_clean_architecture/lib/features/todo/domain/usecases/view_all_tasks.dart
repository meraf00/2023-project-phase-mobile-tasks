import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

import '../entities/task.dart';
import '../repositories/task_repository.dart';

class ViewAllTasks extends UseCase<List<Task>, NoParams> {
  final TaskRepository _taskRepository;

  ViewAllTasks(this._taskRepository);

  @override
  Future<Either<Failure, List<Task>>> call(NoParams params) async {
    return await _taskRepository.getTasks();
  }
}
