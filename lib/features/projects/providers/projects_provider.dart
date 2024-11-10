import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';
import 'package:spec_app/features/projects/data/state/projects_state.dart';

final projectsDataProvider =
    StateNotifierProvider<ProjectsDataNotifier, ProjectsState>((ref) => ProjectsDataNotifier());

class ProjectsDataNotifier extends StateNotifier<ProjectsState> {
  ProjectsDataNotifier() : super(ProjectsState()) {
    projects = FirebaseFirestore.instance.collection('projects');
    getProjects();
  }

  late final CollectionReference projects;

  Future<void> getProjects() async {
    state = state.copyWith(modelState: ModelState.processing);
    List<ProjectModel> projectList = [];
    var values = await projects
        .get()
        .catchError((error) => state = state.copyWith(modelState: ModelState.error, message: error));

    for (var v in values.docs) {
      Map<String, dynamic> data = v.data()! as Map<String, dynamic>;
      var project = ProjectModel.fromJson(data);
      var idProject = project.copyWith(id: v.id);
      projectList.add(idProject);
    }
    state = state.copyWith(projects: projectList, modelState: ModelState.success);
  }

  Future<void> saveProject(MaintenanceMode mode) async {
    state = state.copyWith(modelState: ModelState.processing);

    if (state.selectedProject != null) {
      var p = state.selectedProject;
      var json = p!.toJson();
      if (mode == MaintenanceMode.create) {
        await projects.add(json).then((value) => getProjects());
      } else if (mode == MaintenanceMode.edit) {
        await projects.doc(p.id).set(p);
      }
    }
  }

  updateProject(ProjectModel project) {
    state = state.copyWith(selectedProject: project);
  }
}
