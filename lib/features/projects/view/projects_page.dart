import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/providers/user_provider.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';
import 'package:spec_app/features/projects/providers/projects_provider.dart';
import 'package:spec_app/features/projects/view/project_maintenance.dart';
import 'package:spec_app/features/projects/view/projects_layout.dart';

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Projektek"),
        actions: [
          IconButton(
              onPressed: () {
                ref.watch(userDataProvider.notifier).setUser(null);
                context.replace("/login");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(projectsDataProvider.notifier).updateProject(ProjectModel());
          showGeneralDialog(
              barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
              transitionDuration: Duration(milliseconds: 200),
              barrierColor: Theme.of(context).colorScheme.primary,
              context: context,
              pageBuilder: (context, animation, secAnimation) =>
                  ProjectMaintenance(maintenanceMode: MaintenanceMode.create));
        },
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
