import 'package:flutter/material.dart';
import 'add_task_page.dart';
import '../widgets/display_task_widget.dart';
import '../models/task.dart';

// The main home page displaying the list of tasks
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// State for HomePage
class _HomePageState extends State<HomePage> {
  // List of tasks
  final List<Task> _tasks = [];

  // Build the UI
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
      // Display list of tasks or a message if empty
      body: _tasks.isEmpty
          ? const Center(child: Text('No tasks yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                // Display each task in a card
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TaskWidget(task: _tasks[index]),
                  ),
                );
              },
            ),
      // Button to add a new task
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to AddTaskPage and wait for the result
          final result = await Navigator.push<Task?>(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          // If a new task was created, add it to the list
          if (result != null) {
            setState(() => _tasks.add(result));
          }
        },
        // Icon for the add task button
        child: const Icon(Icons.add),
      ),
    );
  }
}
