import 'dart:convert';

Note noteFromMap(String str) => Note.fromMap(json.decode(str));

String noteToMap(Note data) => json.encode(data.toMap());

List<Note> noteListFromMap(String str) =>
    List<Note>.from(json.decode(str).map((x) => Note.fromMap(x)));

String noteListToMap(List<Note> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Note {
  Note({
    this.id,
    this.user,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String user;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
        content: json["content"] == null ? null : json["content"],
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
        "user": user == null ? null : user,
        "content": content == null ? null : content,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
