import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../config/config.dart';
import '../data/entites/task_entity.dart';

final String apiBaseUrl = dotenv.env['API_URL'] ?? '';

Future<TaskEntity> getTaskByIdApi(int taskId) async {
  final url = Uri.parse('$apiBaseUrl/tasks/$taskId');
  final response = await http.get(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${await Config.getAccessToken()}'}
  );

  if (response.statusCode == 200) {
    return TaskEntity.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load task');
  }
}

Future<List<TaskEntity>> getCompletedTasksApi(String username) async {
  final url = Uri.parse('$apiBaseUrl/tasks/completed/$username');
  final response = await http.get(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${await Config.getAccessToken()}'}
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    if (jsonList.isEmpty) {
      return [];
    }

    List<TaskEntity> listCompletedTasks = jsonList.map((json) => TaskEntity.fromJson(json)).toList();
    return listCompletedTasks;
  } else {
    throw Exception('Failed to load tasks');
  }
}

Future<List<TaskEntity>> getPendingTasksApi(String username) async {
  final url = Uri.parse('$apiBaseUrl/tasks/pending/$username');
  final response = await http.get(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${await Config.getAccessToken()}'}
  );
  if (kDebugMode) {
    print('Respuesta de la API: ${response.statusCode} - ${response.body}');
  }

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    if (jsonList.isEmpty) {
      return [];
    }

    List<TaskEntity> listPendingTasks = jsonList.map((json) => TaskEntity.fromJson(json)).toList();
    if (kDebugMode) {
      print('Lista de tareas pendientes: $listPendingTasks');
    }
    return listPendingTasks;
  } else {
    throw Exception('Failed to load tasks');
  }
}

Future<void> deleteTaskApi(int taskId) async {
  final url = Uri.parse('$apiBaseUrl/tasks/$taskId');
  final response = await http.delete(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${await Config.getAccessToken()}'}
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete task');
  }
}

Future<bool> setCompletedTaskApi(int taskId) async {
  final url = Uri.parse('$apiBaseUrl/tasks/set-completed/$taskId');
  final response = await http.patch(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${await Config.getAccessToken()}'}
  );

  return (response.statusCode == 200);
}



Future<bool> setPendingTaskApi(int taskId) async {
  final url = Uri.parse('$apiBaseUrl/tasks/set-pending/$taskId');
  final response = await http.patch(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${await Config.getAccessToken()}'}
  );

  return (response.statusCode == 200);
}

Future<TaskEntity> createTaskApi(TaskEntity task) async {
  final url = Uri.parse('$apiBaseUrl/tasks');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${await Config.getAccessToken()}'},
    body: jsonEncode(task.toJson()),
  );

  if (response.statusCode == 201) {
    return TaskEntity.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create task');
  }
}

Future<TaskEntity> updateTaskApi(TaskEntity task) async {
  final url = Uri.parse('$apiBaseUrl/tasks/${task.id}');
  final response = await http.patch(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${await Config.getAccessToken()}'},
    body: jsonEncode(task.toJson()),
  );

  if (response.statusCode == 200) {
    return TaskEntity.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update task');
  }
}