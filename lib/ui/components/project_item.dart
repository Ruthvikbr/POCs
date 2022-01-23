import 'package:flutter/material.dart';
import 'package:pocs/models/project.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    Key? key,
    required this.poc,
    required this.onPress,
  }) : super(key: key);

  final Project poc;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 5,
            height: 60,
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.green)),
          ),
          const SizedBox(
            width: 15,
            height: 60,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                poc.projectName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                poc.projectTechStack,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onPress,
    );
  }
}
