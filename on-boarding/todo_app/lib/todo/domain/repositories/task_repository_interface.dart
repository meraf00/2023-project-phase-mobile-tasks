import '../entities/task.dart';

abstract class ITaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> getTask(int id);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
}
