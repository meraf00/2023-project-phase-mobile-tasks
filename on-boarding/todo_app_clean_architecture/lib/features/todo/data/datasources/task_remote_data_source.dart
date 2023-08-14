import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTask(int id);
  Future<TaskModel> createTask(TaskModel todo);
  Future<void> updateTask(TaskModel todo);
  Future<void> deleteTask(int id);
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
  Future<void> deleteTask(int id) async {
    final response = await client.delete(
      Uri.parse('$apiBaseUrl/task/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException(message: 'Failed to delete task');
    }
  }

  @override
  Future<TaskModel> getTask(int id) async {
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
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final response = await client.get(Uri.parse('$apiBaseUrl/task'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      try {
        final decoded = jsonDecode(response.body);
        final taskModels =
            decoded.map<TaskModel>((e) => TaskModel.fromJson(e)).toList();
        return taskModels;
      } on FormatException {
        throw ServerException(message: 'Invalid JSON format');
      }
    } else {
      throw ServerException(message: 'Failed to load tasks');
    }
  }

  @override
  Future<void> updateTask(TaskModel todo) async {
    final response = await client.put(
      Uri.parse('$apiBaseUrl/task'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode != 200) {
      throw ServerException(message: 'Failed to update task');
    }
  }
}
