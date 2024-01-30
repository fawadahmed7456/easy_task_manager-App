import 'package:flutter/material.dart';

class TaskModel {
  int? id;
  String title;
  String note;
  int isCompleted;
  String date;
  String startTime;
  String endTime;
  Color color; // Change type to Color
  int remind;
  String priority;

  TaskModel({
    this.id,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color, // Change type to Color
    required this.remind,
    required this.priority,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      isCompleted: json['isCompleted'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      color: Color(json['color']), // Convert int to Color
      remind: json['remind'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color.value; // Convert Color to int for serialization
    data['remind'] = remind;
    data['priority'] = priority;
    return data;
  }
}
