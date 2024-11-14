import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:intl/intl.dart';

class UpdateTaskPage extends StatelessWidget {
  final ParseObject task;

  UpdateTaskPage({required this.task});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController =
      TextEditingController(text: task.get('title'));
    final TextEditingController _bodyController =
      TextEditingController(text: task.get('body'));
    final TextEditingController _dueDateController =
      TextEditingController(text: task.get('dueDate'));

    Future<void> updateTask(BuildContext context) async {
      final String title = _titleController.text.trim();
      final String body = _titleController.text.trim();
      final String dueDate = _dueDateController.text.trim();

      task.set('title', title);
      task.set('body', body);
      task.set('dueDate', dueDate);

      final ParseResponse response = await task.save();

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task updated successfully!')),
        );

        // Pass the updated task back to the previous screen
        Navigator.pop(context, task);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating task: ${response.error!.message}')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _dueDateController,  // the controller
              decoration: InputDecoration(labelText: 'Due Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => updateTask(context),
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}