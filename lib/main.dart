import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<Map<String, dynamic>> _todoItems =
      []; // Store tasks and their status
  final TextEditingController _controller = TextEditingController();

  // Function to add a new task
  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add({'task': task, 'isDone': false});
      });
      _controller.clear();
    }
  }

  // Function to mark a task as done/undone
  void _toggleTaskStatus(int index) {
    setState(() {
      _todoItems[index]['isDone'] = !_todoItems[index]['isDone'];
    });
  }

  // Function to delete a task
  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  // UI to build each task item
  Widget _buildTodoItem(int index) {
    final task = _todoItems[index];
    return ListTile(
      title: Text(
        task['task'],
        style: TextStyle(
          decoration: task['isDone'] ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        value: task['isDone'],
        onChanged: (value) => _toggleTaskStatus(index),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => _deleteTodoItem(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter a task',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addTodoItem(_controller.text),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) => _buildTodoItem(index),
              ),
            ),
            Text('We have connected this app with github'),
          ],
        ),
      ),
    );
  }
}
