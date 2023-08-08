import 'package:dartz/dartz.dart' hide Task;
import '../../../../core/error/failures.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_mapper.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> createTask(Task task) async {
    await localDataSource.createTask(task.toModel());
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) async {
    await localDataSource.deleteTask(id);
    return const Right(null);
  }

  @override
  Future<Either<Failure, Task>> getTask(int id) async {
    final task = await localDataSource.getTask(id);
    return Right(task.toEntity());
  }

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    final taskModels = await localDataSource.getTasks();
    final tasks = taskModels.map((e) => e.toEntity()).toList();
    return Right(tasks);
  }

  @override
  Future<Either<Failure, void>> updateTask(Task task) async {
    return Right(localDataSource.updateTask(task.toModel()));
  }
}
