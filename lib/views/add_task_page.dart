import 'package:flutter/material.dart';
import '../models/task.dart';

// Where the user can add a new task
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

// State for AddTaskPage
class _AddTaskPageState extends State<AddTaskPage> {
  // Form key and controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime? deadline;
  bool reminderEnabled = false;
  Color selectedColor = Colors.blue;
  IconData selectedCategory = Icons.work;

  // Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _titleField(),
              _descriptionField(),
              _deadlinePicker(context),
              _categoryPicker(),
              _colorPicker(),
              _reminderSwitch(),
              const SizedBox(height: 20),
              _saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Title input field
  Widget _titleField() {
    return TextFormField(
      controller: titleController,
      decoration: const InputDecoration(labelText: 'Title'),
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter a title' : null,
    );
  }

  // Description input field
  Widget _descriptionField() {
    return TextFormField(
      controller: descriptionController,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
    );
  }

  // Deadline picker
  Widget _deadlinePicker(BuildContext context) {
    return ListTile(
      title: Text(
        deadline == null
            ? 'Select Deadline'
            : 'Deadline: ${deadline!.toLocal()}'.split(' ')[0],
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          setState(() => deadline = date);
        }
      },
    );
  }

  // Category picker
  Widget _categoryPicker() {
    final categories = [Icons.work, Icons.school, Icons.home, Icons.favorite];

    return Wrap(
      spacing: 10,
      children: categories.map((icon) {
        return ChoiceChip(
          label: Icon(icon),
          selected: selectedCategory == icon,
          onSelected: (_) {
            setState(() => selectedCategory = icon);
          },
        );
      }).toList(),
    );
  }

  // Color picker
  Widget _colorPicker() {
    final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange];

    return Wrap(
      spacing: 10,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () => setState(() => selectedColor = color),
          child: CircleAvatar(
            backgroundColor: color,
            child: selectedColor == color
                ? const Icon(Icons.check, color: Colors.white)
                : null,
          ),
        );
      }).toList(),
    );
  }

  // Reminder switch
  Widget _reminderSwitch() {
    return SwitchListTile(
      title: const Text('Set Reminder'),
      value: reminderEnabled,
      onChanged: (value) {
        setState(() => reminderEnabled = value);
      },
    );
  }

  // Save button
  Widget _saveButton() {
    return ElevatedButton(
      child: const Text('Save Task'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final newTask = Task(
            title: titleController.text,
            description: descriptionController.text,
            deadline: deadline,
            category: selectedCategory,
            color: selectedColor,
            reminder: reminderEnabled,
          );

          Navigator.pop(context, newTask);
        }
      },
    );
  }

  // Dispose controllers
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
