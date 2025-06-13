import '../entities/project.dart';
import '../entities/task.dart';

abstract class ProjectRepository {
  Future<List<Project>> getProjects();
  Future<void> addProject(Project project);
  Future<List<Task>> getTasks(String projectId);
  Future<void> addTask(Task task);
  Future<void> toggleTaskStatus(String taskId);
}