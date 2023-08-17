import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';

import '../models/task_model.dart';

/// Shared preference key for storing cached tasks
const sharedPreferenceStorageKey = 'CACHED_TASKS';

/// Shared preference key for storing last used id
const sharedPreferenceIdKey = 'CACHED_TASKS_LAST_USED_ID';

/// Interface for local data source
abstract class TaskLocalDataSource {
  Future<void> cacheTasks(List<TaskModel> tasks);
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTask(String id);
  Future<TaskModel> createTask(TaskModel todo);
  Future<TaskModel> updateTask(TaskModel todo);
  Future<TaskModel> deleteTask(String id);
}

/// Implementation of [TaskLocalDataSource]
///
/// Uses [SharedPreferences] to store cached tasks
class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSourceImpl({required this.sharedPreferences});

  /// Generates a new id for a task
  ///
  /// Increments the last used id by 1 that's stored in [SharedPreferences] with key
  /// [sharedPreferenceIdKey] and returns it
  Future<String> _generateId() async {
    int id = sharedPreferences.getInt(sharedPreferenceIdKey) ?? 1;
    await sharedPreferences.setInt(sharedPreferenceIdKey, id + 1);
    return id.toString();
  }

  @override
  Future<void> cacheTasks(List<TaskModel> tasks) async {
    await sharedPreferences.setString(
        sharedPreferenceStorageKey, jsonEncode(tasks));
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final tasks = await getTasks();

    final id = await _generateId();

    task = TaskModel(
        id: id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate,
        completed: task.completed);

    tasks.add(task);

    await sharedPreferences.setString(
        sharedPreferenceStorageKey, jsonEncode(tasks));

    return task;
  }

  @override
  Future<TaskModel> getTask(String id) async {
    final tasks = await getTasks();

    for (final task in tasks) {
      if (task.id == id) {
        return task;
      }
    }

    throw CacheException.cacheNotFound();
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final serialized =
        sharedPreferences.getString(sharedPreferenceStorageKey) ?? '[]';
    try {
      final json = jsonDecode(serialized) as List;
      final tasks = json.map<TaskModel>((e) => TaskModel.fromJson(e)).toList();
      return tasks;
    } catch (e) {
      throw CacheException.readError();
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    final tasks = await getTasks();

    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].id == task.id) {
        tasks[i] = task;
        await sharedPreferences.setString(
            sharedPreferenceStorageKey, jsonEncode(tasks));
        return task;
      }
    }

    throw CacheException.cacheNotFound();
  }

  @override
  Future<TaskModel> deleteTask(String id) async {
    final tasks = await getTasks();

    final task = await getTask(id);

    tasks.removeWhere((element) => element.id == id);

    await sharedPreferences.setString(
        sharedPreferenceStorageKey, jsonEncode(tasks));

    return task;
  }
}
