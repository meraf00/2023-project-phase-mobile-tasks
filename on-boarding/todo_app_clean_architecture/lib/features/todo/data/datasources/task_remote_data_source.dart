import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTask(int id);
  Future<TaskModel> createTask(TaskModel todo);
  Future<TaskModel> updateTask(TaskModel todo);
  Future<TaskModel> deleteTask(int id);
}

class TaskRemoteDataSourceImpl extends TaskRemoteDataSource {
  final http.Client client;

  TaskRemoteDataSourceImpl({required this.client});

  @override
  Future<TaskModel> createTask(TaskModel todo) async {
    final response = await client.post(
      Uri.parse('$apiBaseUrl/task'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      try {
        final decoded = jsonDecode(response.body);
        final taskModel = TaskModel.fromJson(decoded);
        return taskModel;
      } on FormatException {
        throw ServerException(message: 'Invalid JSON format');
      }
    } else {
      throw ServerException(message: 'Failed to load tasks');
    }
  }

  @override
  Future<TaskModel> deleteTask(int id) async {
    try {
      final response = await client.delete(
        Uri.parse('$apiBaseUrl/task/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw ServerException(message: 'Failed to delete task');
      }

      try {
        final decoded = jsonDecode(response.body);
        final taskModel = TaskModel.fromJson(decoded);
        return taskModel;
      } on FormatException {
        throw ServerException(message: 'Invalid JSON format');
      }
    } catch (e) {
      throw ServerException(message: 'Network error');
    }
  }

  @override
  Future<TaskModel> getTask(int id) async {
    try {
      final response = await client.get(Uri.parse('$apiBaseUrl/task/$id'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        try {
          final decoded = jsonDecode(response.body);
          final taskModel = TaskModel.fromJson(decoded);
          return taskModel;
        } on FormatException {
          throw ServerException(message: 'Invalid JSON format');
        }
      } else {
        throw ServerException(message: 'Failed to load tasks');
      }
    } catch (e) {
      throw ServerException(message: 'Network error');
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await client.get(Uri.parse('$apiBaseUrl/task'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        try {
          final decoded = jsonDecode(response.body);
          final taskModels =
              decoded.map<TaskModel>((e) => TaskModel.fromJson(e)).toList();
          return taskModels;
        } catch (e) {
          throw ServerException(message: 'Invalid JSON format');
        }
      } else {
        throw ServerException(message: 'Failed to load tasks from server');
      }
    } catch (e) {
      throw ServerException(message: 'Network error');
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel todo) async {
    try {
      final response = await client.put(
        Uri.parse('$apiBaseUrl/task'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(todo.toJson()),
      );

      if (response.statusCode != 200) {
        throw ServerException(message: 'Failed to update task');
      }

      return todo;
    } catch (e) {
      throw ServerException(message: 'Network error');
    }
  }
}
