import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';

import '../providers/projects_provider.dart';

class ProjectMaintenance extends ConsumerWidget {
  const ProjectMaintenance({required this.project, required this.maintenanceMode, super.key});

  final ProjectModel project;
  final MaintenanceMode maintenanceMode;

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var project = ref.watch(projectsDataProvider).selectedProject;
    return Dialog.fullscreen(
        child: Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: () => context.pop(), icon: Icon(Icons.close)),
          title: Text(maintenanceMode == MaintenanceMode.create ? "Új Projekt" : "Projekt szerkesztése"),
          actions: [
            MaterialButton(
                onPressed: () =>
                    ref.read(projectsDataProvider.notifier).saveProject(maintenanceMode).then((value) => context.pop()),
                child: Text("Mentés"))
          ]),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BaseTextFormField(
                    initialValue: project?.maintainer,
                    labelText: 'Karbantartó',
                    onChanged: (String text) {},
                  ),
                  BaseTextFormField(
                    initialValue: project?.address,
                    labelText: 'Helyszín',
                    onChanged: (String text) {},
                  ),
                  BaseTextFormField(
                    initialValue: project?.contractNr,
                    labelText: 'Szerződésszám',
                    onChanged: (String text) {},
                  ),
                  BaseTextFormField(
                    initialValue: project?.operator,
                    labelText: 'Szerelést végző személy neve',
                    onChanged: (String text) {},
                  ),
                  BaseTextFormField(
                    initialValue: project?.operator,
                    labelText: 'Tűzvédelmi vizsg. biz. száma',
                    onChanged: (String text) {},
                  )
                ],
              ),
            ),
          )),
    ));
  }
}
