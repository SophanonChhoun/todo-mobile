import 'dart:convert';

Category categoryFromMap(String str) => Category.fromMap(json.decode(str));

String categoryToMap(Category data) => json.encode(data.toMap());

List<Category> categoryListFromMap(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromMap(x)));

String categoryListToMap(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Category {
  Category({
    this.id,
    this.title,
    this.colorNum,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String title;
  int colorNum;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        colorNum: json["colorNum"] == null ? null : json["colorNum"],
        user: json["user"] == null ? null : json["user"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "colorNum": colorNum == null ? null : colorNum,
        "user": user == null ? null : user,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
