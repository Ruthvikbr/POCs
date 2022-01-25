import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocs/bloc/project_bloc.dart';
import 'package:pocs/models/project.dart';

class AddOrUpdateProjects extends StatefulWidget {
  const AddOrUpdateProjects({Key? key, this.project,required this.projectBloc}) : super(key: key);
  final Project? project;
  final ProjectBloc projectBloc;

  @override
  _AddOrUpdateProjectsState createState() => _AddOrUpdateProjectsState();
}

class _AddOrUpdateProjectsState extends State<AddOrUpdateProjects> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = "";
  String? _projectDescription = "";
  String _projectTechStack = "";
  late int? _priority;
  String _projectCompletionDate = "";
  String? _projectGithubLink = "";
  String? _projectResourceLink = "";
  String _projectStatus = "";

  late int id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime date = widget.project != null
        ? DateTime.parse(widget.project!.projectCompletionDate)
        : DateTime.now();
    id = (widget.project != null ? widget.project!.id : 0)!;
    _projectName = widget.project != null ? widget.project!.projectName : "";
    _projectDescription =
        widget.project != null ? widget.project!.projectDescription : "";
    _projectTechStack =
        widget.project != null ? widget.project!.projectTechStack : "";
    _priority = widget.project != null ? widget.project!.priority : null;
    _projectGithubLink =
        widget.project != null ? widget.project!.projectGithubLink : "";
    _projectResourceLink =
        widget.project != null ? widget.project!.projectResourceLink : "";
    _projectCompletionDate =
        widget.project != null ? DateFormat("DD/MM/yyyy").format(date) : "";
    _projectStatus = widget.project != null
        ? widget.project!.projectStatus
        : ProjectStatus.toDo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.project == null
            ? const Text("New project")
            : Text(widget.project!.projectName),
        actions: <Widget>[
          TextButton(
            child: Text(
              widget.project == null ? "Save" : "Update",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onPressed: () => _submit(context),
          )
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildForm(),
                ),
              ),
            ),
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildFormChildren(),
        ));
  }

  List<Widget> _buildFormChildren() {
    DateFormat inputFormat = DateFormat('DD/MM/yyyy');
    return [
      TextFormField(
        readOnly: _projectName != "",
        initialValue: _projectName,
        decoration: const InputDecoration(labelText: "Name *"),
        onSaved: (value) => _projectName = value ?? "",
        validator: (value) => value != null && value.isNotEmpty
            ? null
            : "Project name can't be empty",
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        initialValue: _projectDescription,
        decoration: const InputDecoration(labelText: "Description"),
        onSaved: (value) => _projectDescription = value ?? "",
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        initialValue: _projectTechStack,
        decoration: const InputDecoration(labelText: "Tech stack *"),
        onSaved: (value) => _projectTechStack = value ?? "",
        validator: (value) => value != null && value.isNotEmpty
            ? null
            : "Tech stack can't be empty",
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        initialValue: _priority != null ? "$_priority" : "",
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: "Priority *"),
        onSaved: (value) => _priority = int.parse(value!),
        validator: (value) => value != null && value.isNotEmpty
            ? null
            : "Priority can't be empty",
      ),
      const SizedBox(height: 10.0),
      DropdownButtonFormField(
        value: _projectStatus,
        items: [
          (ProjectStatus.toDo),
          (ProjectStatus.inProgress),
          (ProjectStatus.done),
          (ProjectStatus.onGoingPoc)
        ]
            .map((label) => DropdownMenuItem(
                  child: Text(label.toString()),
                  value: label,
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _projectStatus = value.toString();
          });
        },
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        initialValue: _projectGithubLink,
        decoration: const InputDecoration(labelText: "Github repo"),
        onSaved: (value) => _projectGithubLink = value ?? "",
      ),
      const SizedBox(height: 10.0),
      TextFormField(
        initialValue: _projectResourceLink,
        decoration: const InputDecoration(labelText: "Resources"),
        onSaved: (value) => _projectResourceLink = value ?? "",
      ),
      const SizedBox(height: 10.0),
      InputDatePickerFormField(
        fieldHintText: "MM/DD/YY",
        fieldLabelText: "Completion date",
        firstDate: DateTime(2021),
        lastDate: DateTime(2025),
        initialDate: _projectCompletionDate != ""
            ? inputFormat.parse(_projectCompletionDate)
            : null,
        errorInvalidText: "Project completion date can't be empty",
        errorFormatText: "Please enter a valid date",
        onDateSaved: (date) {
          _projectCompletionDate = "$date";
        },
        onDateSubmitted: (date) {
          _projectCompletionDate = "$date";
        },
      )
    ];
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void _submit(BuildContext context) async {

    if (_validateAndSaveForm()) {

      List<Project> projects = await widget.projectBloc.getProjects();
      final allNames = projects.map((project) => project.projectName).toList();

      if (widget.project == null) {
        if (allNames.contains(_projectName)) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Project exists"),
                  content:
                      const Text("There is already a project with same name"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("OK"),
                    )
                  ],
                );
              });
        } else {
          try {
            final Project newProject = Project(
              projectName: _projectName,
              projectDescription: _projectDescription,
              projectCompletionDate: _projectCompletionDate,
              projectTechStack: _projectTechStack,
              projectGithubLink: _projectGithubLink,
              projectResourceLink: _projectResourceLink,
              priority: _priority ?? 3,
              projectStatus: _projectStatus,
            );
            await widget.projectBloc.addProject(newProject);
          } catch (e) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Something went wrong"),
                    content:
                    const Text("Please try again after some time"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("OK"),
                      )
                    ],
                  );
                });
          }
        }
      } else {
        try {
          Project newProject = widget.project!.copy(
            id: widget.project!.id,
            projectName: _projectName,
            projectDescription: _projectDescription,
            projectCompletionDate: _projectCompletionDate,
            projectTechStack: _projectTechStack,
            projectGithubLink: _projectGithubLink,
            projectResourceLink: _projectResourceLink,
            priority: _priority ?? 3,
            projectStatus: _projectStatus,
          );

          await widget.projectBloc.updateProject(newProject);
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Something went wrong"),
                  content:
                  const Text("Please try again after some time"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("OK"),
                    )
                  ],
                );
              }
          );
        }
      }

      Navigator.of(context).pop();
    }
  }
}
