import 'package:do_it_fixed_fixed/domain/repositories/project_repositories.dart';

import '../entities/project.dart';

class AddProject {
  final ProjectRepository repo;

  AddProject(this.repo);

  Future<void> call(Project project) => repo.addProject(project);
}