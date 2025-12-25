import 'package:flutter/material.dart';
import '../models/task.dart';

// A widget that represents a single task item
class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // Display task details
    return ListTile(
      leading: Icon(
        task.completed ? Icons.check_box : Icons.check_box_outline_blank,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.completed
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      // Show description and deadline if available
      subtitle: task.description.isNotEmpty ? Text(task.description) : null,
      trailing: task.deadline != null
          ? Text('${task.deadline!.toLocal()}'.split(' ')[0])
          : null,
    );
  }
}
