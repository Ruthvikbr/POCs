import 'package:flutter/material.dart';
import 'package:pocs/bloc/project_bloc.dart';
import 'package:pocs/models/project.dart';
import 'package:pocs/ui/components/project_item.dart';
import 'package:pocs/ui/components/projects_list_builder.dart';
import 'package:pocs/ui/screens/add_or_update_projects.dart';
import 'package:provider/provider.dart';

class ProjectsList extends StatelessWidget {
  const ProjectsList({Key? key, required this.projectBloc}) : super(key: key);
  final ProjectBloc projectBloc;

  static Widget create(BuildContext context) {
    return Provider<ProjectBloc>(
      create: (_) => ProjectBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<ProjectBloc>(
        builder: (_, bloc, __) => ProjectsList(projectBloc: bloc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Project>>(
      stream: projectBloc.databaseStream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Projects"),
          ),
          backgroundColor: Colors.white,
          body: ListItemBuilder<Project>(
            snapshot: snapshot,
            itemWidgetBuilder: (context, project) => Dismissible(
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              key: Key('job-${project.id}'),
              onDismissed: (direction) => {_deleteProject(project)},
              child: ProjectItem(
                poc: project,
                onPress: () => {
                  navigateToUpdateProjectScreen(
                    context,
                    project,
                  )
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => navigateToAddProjectScreen(context),
            child: const Icon(
              Icons.add,
              color: Colors.black87,
            ),
            elevation: 4,
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }

  void navigateToAddProjectScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddOrUpdateProjects(projectBloc: projectBloc),
    ));
  }

  void navigateToUpdateProjectScreen(BuildContext context, Project project) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddOrUpdateProjects(
        project: project,
        projectBloc: projectBloc,
      ),
    ));
  }

  _deleteProject(Project project) async {
    await projectBloc.deleteProject(project.id);
  }
}
