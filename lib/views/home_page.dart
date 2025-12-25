import 'package:flutter/material.dart';
import 'add_task_page.dart';

import '../widgets/display_task_widget.dart';
import '../models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('To Do'),
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('No tasks yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TaskWidget(task: _tasks[index]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<Task?>(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          if (result != null) {
            setState(() => _tasks.add(result));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
