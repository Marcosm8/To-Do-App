import 'package:flutter/material.dart';

class Task {
  final String title;
  final String description;
  final DateTime? deadline;
  final IconData category;
  final Color color;
  final bool completed;
  final bool reminder;

  Task({
    required this.title,
    required this.description,
    this.deadline,
    required this.category,
    required this.color,
    this.completed = false,
    required this.reminder,
  });
}
