import 'dart:convert';

import 'package:todo_app/models/Note.dart';
import 'package:todo_app/repos/APIRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NoteRepo extends ApiRepository {
  Future readAllNote() async {
    http.Response response =
        await http.get("$baseUrl/notes", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(noteListFromMap, body);
    } else {
      print("Notes Status: ${response.statusCode}");
      print("Notes Body: ${response.body}");
      throw Exception("Error while reading data");
    }
  }

  Future readNote(id) async {
    http.Response response =
        await http.get("$baseUrl/notes/$id", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(noteFromMap, body);
    } else {
      print("Note Status: ${response.statusCode}");
      print("Note Body: ${response.body}");
      throw Exception("Error while reading data");
    }
  }

  Future createNotes(content) async {
    http.Response response = await http.post(
      "$baseUrl/notes",
      headers: await getTokenHeader(),
      body: jsonEncode({"content": content}),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future deletedNote(id) async {
    http.Response response = await http.delete(
      "$baseUrl/notes/$id",
      headers: await getTokenHeader(),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future updatedNote(id, content) async {
    http.Response response = await http.put(
      "$baseUrl/notes/$id",
      headers: await getTokenHeader(),
      body: jsonEncode({"content": content}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
