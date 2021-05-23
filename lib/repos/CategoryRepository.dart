import 'dart:convert';

import 'package:todo_app/models/Category.dart';
import 'package:todo_app/repos/APIRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoryRepo extends ApiRepository {
  Future readCategory() async {
    http.Response response =
        await http.get("$baseUrl/categories", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(categoryListFromMap, body);
    } else {
      print("Categories Status: ${response.statusCode}");
      print("Categories Body: ${response.body}");
      throw Exception("Error while reading data");
    }
  }

  Future createCategory(title, colorNum) async {
    http.Response response = await http.post(
      "$baseUrl/categories",
      headers: await getTokenHeader(),
      body: jsonEncode({"title": title, "colorNum": colorNum}),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future deletedCategory(id) async {
    http.Response response = await http.delete(
      "$baseUrl/categories/$id",
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
