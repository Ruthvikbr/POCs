import 'package:flutter/material.dart';
import 'package:pocs/models/project.dart';
import 'package:pocs/ui/components/project_item.dart';

class ProjectsList extends StatefulWidget {
  const ProjectsList({Key? key}) : super(key: key);

  @override
  _ProjectsListState createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  final Project _poc = Project(
    projectName: "POCs",
    projectTechStack: "Flutter",
    projectStatus: "To-Do",
    priority: 1,
    projectCompletionDate: "23-01-2021",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
      ),
      body: ProjectItem(
        poc: _poc,
        onPress: () {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
        elevation: 4,
        backgroundColor: Colors.white,
      ),
    );
  }
}
