class ProjectStatus {
  static const String toDo = "To Do";
  static const String inProgress = "In Progress";
  static const String done = "Done";
  static const String onGoingPoc = "On Going POC";
}

const String tableProjects = "projects";

class ProjectFields {
  static const List<String> values = [
    id,
    projectName,
    projectDescription,
    projectTechStack,
    projectStatus,
    projectGithubLink,
    projectResourceLink,
    priority,
    projectCompletionDate,
  ];

  static const String id = "_id";
  static const String projectName = "projectName";
  static const String projectTechStack = "projectTechStack";
  static const String projectDescription = "projectDescription";
  static const String projectStatus = "projectStatus";
  static const String projectGithubLink = "projectGithubLink";
  static const String projectResourceLink = "projectResourceLink";
  static const String priority = "priority";
  static const String projectCompletionDate = "projectCompletionDate";
}

class Project {
  Project({
    this.id,
    required this.projectName,
    required this.projectTechStack,
    this.projectDescription = "",
    required this.projectStatus,
    this.projectGithubLink = "",
    this.projectResourceLink = "",
    required this.priority,
    required this.projectCompletionDate,
  });

  final int? id;
  final String projectName;
  final String projectTechStack;
  final String? projectDescription;
  final String projectStatus;
  final String? projectGithubLink;
  final String? projectResourceLink;
  final int priority;
  final String projectCompletionDate;

  Map<String, dynamic> toMap() {
    return {
      ProjectFields.id: id,
      ProjectFields.projectName: projectName,
      ProjectFields.projectTechStack: projectTechStack,
      ProjectFields.projectDescription: projectDescription,
      ProjectFields.projectStatus: projectStatus,
      ProjectFields.projectGithubLink: projectGithubLink,
      ProjectFields.projectResourceLink: projectResourceLink,
      ProjectFields.priority: priority,
      ProjectFields.projectCompletionDate: projectCompletionDate,
    };
  }

  Project copy({
     int? id,
     String? projectName,
     String? projectTechStack,
     String? projectDescription,
     String? projectStatus,
     String? projectGithubLink,
     String? projectResourceLink,
     int? priority,
     String? projectCompletionDate,
}) {
    return Project(
        id: id ?? this.id,
        projectName: projectName ?? this.projectName,
        projectDescription: projectDescription ?? this.projectDescription,
        projectTechStack: projectTechStack ?? this.projectTechStack,
        projectStatus: projectStatus ?? this.projectStatus,
        projectGithubLink: projectGithubLink ?? this.projectGithubLink,
        projectResourceLink: projectResourceLink ?? this.projectResourceLink,
        priority: priority ?? this.priority,
        projectCompletionDate: projectCompletionDate ?? this.projectCompletionDate,
    );
  }

  static Project fromJson(Map<String, dynamic> json) => Project(
        id: json[ProjectFields.id],
        projectName: json[ProjectFields.projectName],
        projectDescription: json[ProjectFields.projectDescription],
        projectTechStack: json[ProjectFields.projectTechStack],
        projectStatus: json[ProjectFields.projectStatus],
        projectGithubLink: json[ProjectFields.projectGithubLink],
        projectResourceLink: json[ProjectFields.projectResourceLink],
        projectCompletionDate: json[ProjectFields.projectCompletionDate],
        priority: json[ProjectFields.priority],
      );
}
