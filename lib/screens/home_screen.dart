import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];

  void _addTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        tasks.add(result);
      });
    }
  }

  void _editTask(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: tasks[index]),
      ),
    );

    if (result != null) {
      if (result == 'delete') {
        setState(() {
          tasks.removeAt(index);
        });
      } else if (result is Map<String, dynamic>) {
        setState(() {
          tasks[index] = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Today\'s Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('No tasks yet. Tap + to start!', 
                    style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  title: tasks[index]['title'],
                  isCompleted: tasks[index]['isCompleted'],
                  onToggle: (val) {
                    setState(() {
                      tasks[index]['isCompleted'] = val ?? false;
                    });
                  },
                  onEdit: () => _editTask(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
