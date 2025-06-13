
import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/task_list_page.dart';
import 'package:do_it_fixed_fixed/main/widgets/button.dart';
import 'package:do_it_fixed_fixed/main/widgets/custom_appbar.dart';
import 'package:do_it_fixed_fixed/main/widgets/date_picker_field.dart';
import 'package:do_it_fixed_fixed/main/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class TaskCreationPage extends StatefulWidget {
  final String projectId;
  const TaskCreationPage({super.key, required this.projectId});

  @override
  State<TaskCreationPage> createState() => _TaskCreationPageState();
}

class _TaskCreationPageState extends State<TaskCreationPage> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _assignedMemberController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = picked.toIso8601String().split('T').first;
    }
  }

  Future<void> _saveTaskLocally(Map<String, dynamic> task) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'tasks_${widget.projectId}';
    final existingTasksString = prefs.getString(key);
    List<dynamic> tasks = existingTasksString != null ? jsonDecode(existingTasksString) : [];
    tasks.add(task);
    await prefs.setString(key, jsonEncode(tasks));
  }

  void _handleTaskCreation() async {
    final String id = const Uuid().v4();
    final String taskName = _taskNameController.text.trim();
    final String fromDate = _fromDateController.text.trim();
    final String toDate = _toDateController.text.trim();
    final String assignedMember = _assignedMemberController.text.trim();
    final List<String> tags = _tagsController.text.trim().split(',').map((e) => e.trim()).toList();
    final String comment = _commentController.text.trim();

    if (taskName.isEmpty || fromDate.isEmpty || toDate.isEmpty || assignedMember.isEmpty || tags.isEmpty || comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final Map<String, dynamic> task = {
      'id': id,
      'projectId': widget.projectId,
      'taskName': taskName,
      'fromDate': fromDate,
      'toDate': toDate,
      'assignedMember': assignedMember,
      'tags': tags,
      'comment': comment,
    };

    await _saveTaskLocally(task);

    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskListPage(projectId: task['id'],),
                        ),
                      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(

            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add Task",
                  style: MarkTextStyles.headingSemiBold24.copyWith(
                    color: Colors.black
                  ),
                ),
              ),
              CustomInputField(
                label: 'Task Name',
                controller: _taskNameController,
                hint: 'Enter task name', isMultiline: false,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomDatePickerField(
                      label: 'Created(from)',
                      controller: _fromDateController,
                      onTap: () => _selectDate(context, _fromDateController),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDatePickerField(
                      label: 'End(To) ',
                      controller: _toDateController,
                      onTap: () => _selectDate(context, _toDateController),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Assign To',
                controller: _assignedMemberController,
                hint: 'Enter member name', isMultiline: false,
              ),
              Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Comma-separated list',
                      style: MarkTextStyles.bodyLight14.copyWith(
                        color: AppTheme.grey
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Tags',
                controller: _tagsController,
                hint: 'Comma-separated tags', isMultiline: false,
              ),
              Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Comma-separated list',
                      style: MarkTextStyles.bodyLight14.copyWith(
                        color: AppTheme.grey
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Comment',
                controller: _commentController,
                hint: 'Add comment',
                isMultiline: true,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Add Task',
                onPressed: _handleTaskCreation, label: 'Create Task',
              )
            ],
          ),
        ),
      ),
    );
  }
}
