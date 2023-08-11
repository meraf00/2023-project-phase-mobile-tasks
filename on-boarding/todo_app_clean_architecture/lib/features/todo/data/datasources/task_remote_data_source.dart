import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTask(int id);
  Future<TaskModel> createTask(TaskModel todo);
  Future<void> updateTask(TaskModel todo);
  Future<TaskModel> deleteTask(int id);
}

class TaskRemoteDataSourceImpl extends TaskRemoteDataSource {
  @override
  Future<TaskModel> createTask(TaskModel todo) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<TaskModel> deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<TaskModel> getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(TaskModel todo) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
