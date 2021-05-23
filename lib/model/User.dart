import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app/model/Category.dart';

class User {
  List<Category> categories = [];

  addCategory(String title, Color colors) {
    categories.add(Category(title, colors));
  }

  deleteCategory(categoryNumber) {
    categories.removeAt(categoryNumber);
  }
}

User user = new User();
