import 'package:flutter/material.dart';
import 'package:todo_app/model/Task.dart';

class Category {
  String title;
  Color colors;
  List<Task> tasks = [];

  Category(title, colors) {
    this.title = title;
    this.colors = colors;
  }

  getTasksAmount() {
    return this.tasks.length;
  }

  addTask(String title) {
    tasks.add(Task(title));
  }

  updateTaskStatus(status, taskNumber) {
    tasks[taskNumber].done = status;
  }

  deleteTask(taskNumber) {
    tasks.removeAt(taskNumber);
  }
}
