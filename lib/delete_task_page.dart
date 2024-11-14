import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class DeleteTaskPage extends StatelessWidget {
  final ParseObject task;

  DeleteTaskPage({required this.task});

  Future<void> deleteTask(BuildContext context) async {
    final ParseResponse response = await task.delete();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task deleted successfully!')),
      );
      // Navigator.popUntil(context, ModalRoute.withName('/TodoPage')); // Navigate back to TodoPage
      // Navigator.of(context).popUntil((route) => route.settings.name == '/todo');
      Navigator.pushNamed(context,'/todo');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting task: ${response.error!.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to delete this task?'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => deleteTask(context),
              child: Text('Delete Task'),
            ),
          ],
        ),
      ),
    );
  }
}
