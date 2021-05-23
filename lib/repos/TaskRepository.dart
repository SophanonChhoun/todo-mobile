import 'dart:convert';

import 'package:todo_app/models/Task.dart';
import 'package:todo_app/repos/APIRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TaskRepo extends ApiRepository {
  Future readTasks(id) async {
    http.Response response =
        await http.get("$baseUrl/tasks/$id", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(taskListFromMap, body);
    } else {
      print("Task Status: ${response.statusCode}");
      print("Task Body: ${response.body}");
      throw Exception("Error while reading data");
    }
  }

  Future createTask(title, category) async {
    http.Response response = await http.post(
      "$baseUrl/tasks",
      headers: await getTokenHeader(),
      body: jsonEncode({"title": title, "category": category}),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future updateTaskStatus(id, status) async {
    http.Response response = await http.patch(
      "$baseUrl/tasks/$id",
      headers: await getTokenHeader(),
      body: jsonEncode({"status": status}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future deleteTask(id) async {
    http.Response response = await http.delete(
      "$baseUrl/tasks/$id",
      headers: await getTokenHeader(),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
