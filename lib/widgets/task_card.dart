import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function(bool?) onToggle;
  final VoidCallback onEdit;

  const TaskCard({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: isCompleted,
          onChanged: onToggle,
          activeColor: Colors.indigo,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        title: Text(
          title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit_note, color: Colors.indigo),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
