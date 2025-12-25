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
  // Task properties
  DateTime? deadline;
  bool reminderEnabled = false;
  // Color selectedColor = Colors.blue;
  IconData selectedCategory = Icons.work;

  // Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Form for task input
        child: Form(
          key: _formKey,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Various input fields
                    _titleField(),
                    const SizedBox(height: 20),
                    _descriptionField(),
                    const SizedBox(height: 20),
                    _categoryPicker(),
                    const SizedBox(height: 20),
                    _deadlinePicker(context),
                    const SizedBox(height: 20),
                    // _colorPicker(),
                    // const SizedBox(height: 20),
                    _reminderSwitch(),
                    Spacer(),
                    _saveButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Title input field
  Widget _titleField() {
    return TextFormField(
      controller: titleController,
      maxLength: 50,
      decoration: const InputDecoration(labelText: 'Title'),
      // Validation for title
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter a title' : null,
    );
  }

  // Description input field
  Widget _descriptionField() {
    return TextFormField(
      controller: descriptionController,
      maxLength: 100,
      decoration: const InputDecoration(labelText: 'Description'),
    );
  }

  // Deadline picker
  Widget _deadlinePicker(BuildContext context) {
    return ListTile(
      title: Text(
        // Show selected deadline or prompt
        deadline == null
            ? 'Select Deadline'
            // Format the date nicely
            : 'Deadline: ${deadline!.toLocal()}'.split(' ')[0],
      ),
      trailing: const Icon(Icons.calendar_today),
      // Open date picker on tap
      onTap: () async {
        // Show date picker dialog
        final date = await showDatePicker(
          // Parameters for date picker
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        // Update deadline if a date was picked
        if (date != null) {
          setState(() => deadline = date);
        }
      },
    );
  }

  Widget _categoryPicker() {
    // Map each icon to a color
    final Map<IconData, Color> categoryColors = {
      Icons.work: Colors.blue,
      Icons.school: Colors.orange,
      Icons.home: Colors.green,
      Icons.favorite: Colors.red,
    };

    return Wrap(
      spacing: 10,
      children: categoryColors.entries.map((entry) {
        final icon = entry.key;
        final color = entry.value;
        final isSelected = selectedCategory == icon;

        return ChoiceChip(
          label: Icon(
            icon,
            color: isSelected ? Colors.white : color, // Icon color
          ),
          selected: isSelected,
          selectedColor: color, // Chip background when selected
          backgroundColor: color.withOpacity(0.2), // Unselected chip
          onSelected: (_) {
            setState(() => selectedCategory = icon);
          },
        );
      }).toList(),
    );
  }

  // // Color picker
  // Widget _colorPicker() {
  //   // Sample colors
  //   final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange];
  //   // Display colors as selectable circles
  //   return Wrap(
  //     // Spacing between color options
  //     spacing: 10,
  //     // Generate color options
  //     children: colors.map((color) {
  //       // Create a selectable color circle
  //       return GestureDetector(
  //         // Select color on tap
  //         onTap: () => setState(() => selectedColor = color),
  //         // Display the color circle
  //         child: CircleAvatar(
  //           backgroundColor: color,
  //           // Show checkmark if selected
  //           child: selectedColor == color
  //               ? const Icon(Icons.check, color: Colors.white)
  //               : null,
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  // Reminder switch
  Widget _reminderSwitch() {
    // Toggle for reminder
    return SwitchListTile(
      // Label for the switch
      title: const Text('Set Reminder'),
      value: reminderEnabled,
      // Update reminder state on change
      onChanged: (value) {
        setState(() => reminderEnabled = value);
      },
    );
  }

  // Save button
  Widget _saveButton() {
    // Save the new task
    return ElevatedButton(
      // Button label
      child: const Text('Save Task'),
      onPressed: () {
        // Validate form inputs
        if (_formKey.currentState!.validate()) {
          // Create a new Task object
          final newTask = Task(
            title: titleController.text,
            description: descriptionController.text,
            deadline: deadline,
            category: selectedCategory,
            // color: selectedColor,
            reminder: reminderEnabled,
          );
          // Return the new task to the previous screen
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
