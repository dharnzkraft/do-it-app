import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataHelper {
  static Future<List<Map<String, dynamic>>> getProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final projectsString = prefs.getString('projects');
    if (projectsString == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(projectsString));
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('tasks');
    if (tasksString == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(tasksString));
  }

  static Future<int> getProjectCount() async {
    final projects = await getProjects();
    return projects.length;
  }

  static Future<int> getTaskCount() async {
    final tasks = await getTasks();
    return tasks.length;
  }

  static Future<int> getCompletedTaskCount() async {
    final tasks = await getTasks();
    return tasks.where((task) => task['status'] == 'completed').length;
  }

  static Future<int> getOverdueTaskCount() async {
    final tasks = await getTasks();
    return tasks.where((task) => task['status'] == 'overdue').length;
  }
}
