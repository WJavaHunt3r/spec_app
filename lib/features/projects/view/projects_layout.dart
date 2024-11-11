import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/features/doors/providers/doors_provider.dart';
import 'package:spec_app/features/projects/providers/projects_provider.dart';
import 'package:spec_app/features/projects/view/project_maintenance.dart';

class ProjectsLayout extends ConsumerWidget {
  const ProjectsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var projects = ref.watch(projectsDataProvider).projects;
    return RefreshIndicator(
        onRefresh: () => ref.read(projectsDataProvider.notifier).getProjects(),
        child: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              var current = projects[index];
              return Card(
                  child: ListTile(
                title: Text("${current.maintainer} (${current.address})"),
                subtitle: Text(current.operator.toString()),
                onTap: () {
                  context.push("/projects/${current.id}");
                  ref.watch(doorsDataProvider.notifier).setProject(current);
                },
                trailing: IconButton(
                    onPressed: () {
                      ref.read(projectsDataProvider.notifier).updateProject(current);
                      showGeneralDialog(
                          barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                          transitionDuration: Duration(milliseconds: 200),
                          barrierColor: Theme.of(context).colorScheme.primary,
                          context: context,
                          pageBuilder: (context, animation, secAnimation) =>
                              ProjectMaintenance(maintenanceMode: MaintenanceMode.edit));
                    },
                    icon: Icon(Icons.edit)),
              ));
            }));
  }
}
