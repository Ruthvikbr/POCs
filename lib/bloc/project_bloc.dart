import 'dart:async';

import 'package:pocs/database/database.dart';
import 'package:pocs/models/project.dart';

class ProjectBloc {
  ProjectBloc() {
    getProjects();
  }

  final ProjectsDatabase _projectsDatabase = ProjectsDatabase.instance;

  final StreamController<List<Project>> _projectsController =
      StreamController<List<Project>>();

  Stream<List<Project>> get databaseStream => _projectsController.stream;

  void _setProjects(List<Project> projects) =>
      _projectsController.add(projects);

  void dispose() {
    _projectsController.close();
    _projectsDatabase.close();
  }

  get projects => databaseStream;

  Future<List<Project>> getProjects() async {
    List<Project> projects = await _projectsDatabase.getProjects();
    _setProjects(projects);
    return projects;
  }

  Future<void> addProject(Project project) async {
    await _projectsDatabase.insertProject(project);
    getProjects();
  }

  Future<void> updateProject(Project project) async {
    await _projectsDatabase.updateProject(project);
    getProjects();
  }

  Future<void> deleteProject(int? id) async {
    await _projectsDatabase.delete(id);
    getProjects();
  }
}
