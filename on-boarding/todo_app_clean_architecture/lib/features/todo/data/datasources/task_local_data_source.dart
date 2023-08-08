import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/core/error/exception.dart';

import '../models/task_model.dart';

const sharedPreferenceStorageKey = 'CACHED_TASKS';
const sharedPreferenceIdKey = 'CACHED_TASKS_LAST_USED_ID';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTask(int id);
  Future<void> createTask(TaskModel todo);
  Future<void> updateTask(TaskModel todo);
  Future<void> deleteTask(int id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSourceImpl({required this.sharedPreferences});

  Future<int> _generateId() async {
    int id = sharedPreferences.getInt(sharedPreferenceIdKey) ?? 1;
    await sharedPreferences.setInt(sharedPreferenceIdKey, id + 1);
    return id;
  }

  @override
  Future<void> createTask(TaskModel task) async {
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
  }

  @override
  Future<TaskModel> getTask(int id) async {
    final tasks = await getTasks();

    for (final task in tasks) {
      if (task.id == id) {
        return task;
      }
    }

    throw CacheException(message: 'Task not found');
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final serialized =
        sharedPreferences.getString(sharedPreferenceStorageKey) ?? "[]";
    try {
      final json = jsonDecode(serialized) as List;
      final tasks = json.map((e) => TaskModel.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      throw CacheException(message: 'Error when parsing json: $e');
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final tasks = await getTasks();

    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].id == task.id) {
        tasks[i] = task;
        await sharedPreferences.setString(
            sharedPreferenceStorageKey, jsonEncode(tasks));
        return;
      }
    }

    throw CacheException(message: 'Task not found');
  }

  @override
  Future<void> deleteTask(int id) async {
    final tasks = await getTasks();

    tasks.removeWhere((element) => element.id == id);

    await sharedPreferences.setString(
        sharedPreferenceStorageKey, jsonEncode(tasks));
  }
}
