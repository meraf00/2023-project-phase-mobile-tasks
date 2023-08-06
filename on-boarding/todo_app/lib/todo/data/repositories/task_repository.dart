import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository_interface.dart';
import '../datasource/task_store.dart';

class TaskRepository implements ITaskRepository {
  final TaskStore _taskStore;

  TaskRepository([TaskStore? taskStore])
      : _taskStore = taskStore ?? TaskStore.instance;

  @override
  Future<List<Task>> getTasks() async {
    return await _taskStore.getTasks();
  }

  @override
  Future<Task> getTask(int id) async {
    return await _taskStore.getTask(id);
  }

  @override
  Future<void> addTask(Task task) async {
    await _taskStore.createTask(task);
  }

  @override
  Future<void> updateTask(Task task) {
    return _taskStore.updateTask(task);
  }

  @override
  Future<void> deleteTask(int id) {
    return _taskStore.deleteTask(id);
  }
}
