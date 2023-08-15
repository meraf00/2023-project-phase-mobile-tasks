import 'dart:async';

import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource localDataSource;
  final TaskRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Stream<Either<Failure, Task>> createTask(Task task) {
    final controller = StreamController<Either<Failure, Task>>();

    networkInfo.isConnected.then((isConnected) async {
      if (isConnected) {
        try {
          final taskModel = await remoteDataSource.createTask(task.toModel());
          controller.add(Right(taskModel.toEntity()));
        } on ServerException catch (e) {
          controller.add(Left(ServerFailure(message: e.message)));
        }
      }
      final taskModel = await localDataSource.createTask(task.toModel());
      controller.add(Right(taskModel.toEntity()));
    });

    return controller.stream;
  }

  @override
  Stream<Either<Failure, Task>> deleteTask(int id) {
    final controller = StreamController<Either<Failure, Task>>();

    networkInfo.isConnected.then((isConnected) async {
      if (isConnected) {
        try {
          await remoteDataSource.deleteTask(id);
        } on ServerException catch (e) {
          controller.add(Left(ServerFailure(message: e.message)));
        }
      }
      final task = await localDataSource.deleteTask(id);
      controller.add(Right(task.toEntity()));
    });

    return controller.stream;
  }

  @override
  Stream<Either<Failure, Task>> getTask(int id) {
    final controller = StreamController<Either<Failure, Task>>();

    localDataSource.getTask(id).then((taskModel) {
      controller.add(Right(taskModel.toEntity()));
    });

    networkInfo.isConnected.then((isConnected) async {
      if (isConnected) {
        try {
          final taskModel = await remoteDataSource.getTask(id);
          controller.add(Right(taskModel.toEntity()));
        } on ServerException catch (e) {
          controller.add(Left(ServerFailure(message: e.message)));
        }
      } else {
        final task = await localDataSource.getTask(id);
        controller.add(Right(task.toEntity()));
      }
    });

    return controller.stream;
  }

  @override
  Stream<Either<Failure, List<Task>>> getTasks() {
    final controller = StreamController<Either<Failure, List<Task>>>();

    localDataSource.getTasks().then((taskModels) {
      final tasks = taskModels.map((e) => e.toEntity()).toList();
      controller.add(Right(tasks));
    });

    networkInfo.isConnected.then((isConnected) async {
      if (isConnected) {
        try {
          final taskModels = await remoteDataSource.getTasks();
          final tasks = taskModels.map((e) => e.toEntity()).toList();
          controller.add(Right(tasks));
        } on ServerException catch (e) {
          controller.add(Left(ServerFailure(message: e.message)));
        }
      }
    });

    return controller.stream;
  }

  @override
  Stream<Either<Failure, Task>> updateTask(Task task) {
    final controller = StreamController<Either<Failure, Task>>();

    localDataSource.updateTask(task.toModel()).then((updatedTask) {
      controller.add(Right(updatedTask.toEntity()));
    });

    networkInfo.isConnected.then((isConnected) async {
      if (isConnected) {
        try {
          final updatedTask = await remoteDataSource.updateTask(task.toModel());
          controller.add(Right(updatedTask.toEntity()));
        } on ServerException catch (e) {
          controller.add(Left(ServerFailure(message: e.message)));
        }
      }
    });

    return controller.stream;
  }
}
