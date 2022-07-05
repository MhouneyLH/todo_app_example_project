import 'package:flutter/material.dart';
import '../utils.dart';

class TodoField {
  static const createdTime = 'created time';
}

class Todo {
  DateTime? createdTime;
  String? title;
  String? id;
  String? description;
  bool isDone;

  Todo({
    @required this.createdTime,
    @required this.title,
    this.description = '',
    this.id,
    this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        id: json['id'],
        description: json['description'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime ?? DateTime.now()),
        'title': title,
        'id': id,
        'description': description,
        'isDone': isDone,
      };
}
