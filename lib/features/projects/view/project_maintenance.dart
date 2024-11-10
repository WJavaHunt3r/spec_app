import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';

import '../providers/projects_provider.dart';

class ProjectMaintenance extends ConsumerWidget {
  const ProjectMaintenance({required this.maintenanceMode, super.key});

  final MaintenanceMode maintenanceMode;

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProjectModel? project = ref.watch(projectsDataProvider).selectedProject;
    return Dialog.fullscreen(
        child: Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: () => context.pop(), icon: Icon(Icons.close)),
          title: Text(maintenanceMode == MaintenanceMode.create ? "Új Projekt" : "Projekt szerkesztése"),
          actions: [
            MaterialButton(
                onPressed: () {
                  save(ref, context);
                },
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
                    initialValue: project!.maintainer,
                    labelText: 'Karbantartó',
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Nem lehet üres";
                      }
                      return null;
                    },
                    onChanged: (String text) =>
                        ref.watch(projectsDataProvider.notifier).updateProject(project.copyWith(maintainer: text)),
                  ),
                  BaseTextFormField(
                    initialValue: project.address,
                    labelText: 'Helyszín',
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Nem lehet üres";
                      }
                      return null;
                    },
                    onChanged: (String text) =>
                        ref.watch(projectsDataProvider.notifier).updateProject(project.copyWith(address: text)),
                  ),
                  BaseTextFormField(
                    initialValue: project.contractNr,
                    labelText: 'Szerződésszám',
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Nem lehet üres";
                      }
                      return null;
                    },
                    onChanged: (String text) =>
                        ref.watch(projectsDataProvider.notifier).updateProject(project.copyWith(contractNr: text)),
                  ),
                  BaseTextFormField(
                    initialValue: project.operator,
                    labelText: 'Szerelést végző személy neve',
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Nem lehet üres";
                      }
                      return null;
                    },
                    onChanged: (String text) =>
                        ref.watch(projectsDataProvider.notifier).updateProject(project.copyWith(operator: text)),
                  ),
                  BaseTextFormField(
                    initialValue: project.certNumber,
                    textInputAction: TextInputAction.done,
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Nem lehet üres";
                      }
                      return null;
                    },
                    onFieldSubmitted: (text) => save(ref, context),
                    labelText: 'Tűzvédelmi vizsg. biz. száma',
                    onChanged: (String text) =>
                        ref.watch(projectsDataProvider.notifier).updateProject(project.copyWith(certNumber: text)),
                  )
                ],
              ),
            ),
          )),
    ));
  }

  void save(WidgetRef ref, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ref.read(projectsDataProvider.notifier).saveProject(maintenanceMode).then((value) {
        ref.watch(projectsDataProvider.notifier).getProjects();
        context.pop();
      });
    }
  }
}
