
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'update_task_page.dart';
import 'delete_task_page.dart';
import 'todo_page.dart'; // Import TodoPage

class TaskListPage extends StatefulWidget {
  final ParseObject task;

  TaskListPage({required this.task});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task.get('completed') ?? false;
  }

  Future<void> updateTaskCompletion(bool? isComplete) async {
    if (isComplete != null) {
      widget.task.set('completed', isComplete);
      final ParseResponse response = await widget.task.save();

      if (response.success) {
        setState(() {
          _isCompleted = isComplete;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task marked as ${isComplete ? 'complete' : 'incomplete'}!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error marking task: ${response.error!.message}')),
        );
      }
    }
  }

  Future<void> navigateToAddTaskPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TodoPage(),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      final newTask = ParseObject('Task')
        ..set('title', result['title'])
        ..set('body', result['body'])
        ..set('dueDate', result['dueDate'])
        ..set('completed', result['completed']);

      final ParseResponse response = await newTask.save();

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task added successfully!')),
        );

        // Navigate to TaskListPage with the new task
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TaskListPage(task: newTask),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding task: ${response.error!.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(8.0),
              child: Checkbox(
                value: _isCompleted,
                onChanged: updateTaskCompletion,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.task.get('title'),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      widget.task.get('body'),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Due: ${widget.task.get('dueDate')}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UpdateTaskPage(task: widget.task),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DeleteTaskPage(task: widget.task),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddTaskPage,
        child: Icon(Icons.add),
      ),
    );
  }
}