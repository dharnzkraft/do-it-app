
import 'dart:convert';
import 'package:do_it_fixed_fixed/main/widgets/button.dart';
import 'package:do_it_fixed_fixed/main/widgets/date_picker_field.dart';
import 'package:do_it_fixed_fixed/main/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListPage extends StatefulWidget {
  final String projectId;

  const TaskListPage({super.key, required this.projectId});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('tasks_${widget.projectId}');
    setState(() {
      _tasks = tasksString != null ? List<Map<String, dynamic>>.from(jsonDecode(tasksString)) : [];
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks_${widget.projectId}', jsonEncode(_tasks));
  }

  void _deleteTask(int index) async {
    _tasks.removeAt(index);
    await _saveTasks();
    _loadTasks();
  }

  void _showTaskForm({Map<String, dynamic>? task, int? index}) {
    final nameController = TextEditingController(text: task?['name'] ?? '');
    final fromDateController = TextEditingController(text: task?['fromDate'] ?? '');
    final toDateController = TextEditingController(text: task?['toDate'] ?? '');
    final memberController = TextEditingController(text: task?['assignedMember'] ?? '');
    final tagsController = TextEditingController(text: task?['tags']?.join(', ') ?? '');
    final commentController = TextEditingController(text: task?['comment'] ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomInputField(label: 'Task Name', controller: nameController, hint: 'Enter task name', isMultiline: false,),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomDatePickerField(
                        label: 'From Date',
                        controller: fromDateController,
                        onTap: () => _selectDate(context, fromDateController),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDatePickerField(
                        label: 'To Date',
                        controller: toDateController,
                        onTap: () => _selectDate(context, toDateController),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomInputField(label: 'Assign To', controller: memberController, hint: 'Enter member name', isMultiline: false,),
                const SizedBox(height: 12),
                CustomInputField(label: 'Tags', controller: tagsController, hint: 'Comma-separated tags', isMultiline: false,),
                const SizedBox(height: 12),
                CustomInputField(label: 'Comment', controller: commentController, hint: 'Task notes', isMultiline: true),
                const SizedBox(height: 20),
                CustomButton(
                  text: index == null ? 'Add Task' : 'Update Task',
                  onPressed: () async {
                    final newTask = {
                      'name': nameController.text.trim(),
                      'fromDate': fromDateController.text.trim(),
                      'toDate': toDateController.text.trim(),
                      'assignedTo': memberController.text.trim(),
                      'tags': tagsController.text.trim().split(',').map((e) => e.trim()).toList(),
                      'comment': commentController.text.trim(),
                    };
                    if (index == null) {
                      _tasks.add(newTask);
                    } else {
                      _tasks[index] = newTask;
                    }
                    await _saveTasks();
                    Navigator.pop(context);
                    _loadTasks();
                  }, label: index == null ? 'Add Task' : 'Update Task',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = picked.toIso8601String().split('T').first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: _tasks.isEmpty
          ? const Center(child: Text('No tasks found.'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(task['taskName']?? 'No Name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From: ${task['fromDate'] ?? '-'}  →  To: ${task['toDate'] ?? '-'}'),

                        Text('Assigned to: ${task['assignedMember'] ?? 'Unassigned'}'),

                        Text('Tags: ${(task['tags'] as List?)?.join(', ') ?? 'None'}'),

                        Text('Comment: ${task['comment'] ?? ''}'),

                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showTaskForm(task: task, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
