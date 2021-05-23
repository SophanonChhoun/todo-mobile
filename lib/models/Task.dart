import 'dart:convert';

Task taskFromMap(String str) => Task.fromMap(json.decode(str));

String taskToMap(Task data) => json.encode(data.toMap());

List<Task> taskListFromMap(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromMap(x)));

String taskListToMap(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Task {
  Task({
    this.status,
    this.id,
    this.title,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool status;
  String id;
  String title;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        status: json["status"] == null ? null : json["status"],
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        category: json["category"] == null ? null : json["category"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "category": category == null ? null : category,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
