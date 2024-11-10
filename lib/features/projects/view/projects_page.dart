import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';
import 'package:spec_app/features/projects/view/project_maintenance.dart';
import 'package:spec_app/features/projects/view/projects_layout.dart';

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Projektek"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showGeneralDialog(
            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            transitionDuration: Duration(milliseconds: 200),
            barrierColor: Theme.of(context).colorScheme.primary,
            context: context,
            pageBuilder: (context, animation, secAnimation) =>
                ProjectMaintenance(project: ProjectModel(), maintenanceMode: MaintenanceMode.create)),
        label: Text("Új projekt"),
        icon: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: ProjectsLayout(),
      ),
    );
  }
}
