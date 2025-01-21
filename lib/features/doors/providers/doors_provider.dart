import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/doors/data/models/door_model.dart';
import 'package:spec_app/features/doors/data/state/doors_state.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';

final doorsDataProvider =
    StateNotifierProvider.autoDispose<DoorsDataNotifier, DoorsState>((ref) => DoorsDataNotifier());

class DoorsDataNotifier extends StateNotifier<DoorsState> {
  DoorsDataNotifier() : super(DoorsState()) {
    doors = FirebaseFirestore.instance.collection('doors');
  }

  late final CollectionReference doors;

  Future<void> getDoors() async {
    state = state.copyWith(modelState: ModelState.processing);
    List<DoorModel> projectList = [];
    var values = await doors.where("projectId", isEqualTo: state.project?.id).get().catchError((error) {
      state = state.copyWith(modelState: ModelState.error, message: error);
    });

    for (var v in values.docs) {
      Map<String, dynamic> data = v.data()! as Map<String, dynamic>;
      var project = DoorModel.fromJson(data);
      var idDoor = project.copyWith(id: v.id);
      projectList.add(idDoor);
    }
    state = state.copyWith(doors: projectList, modelState: ModelState.success);
  }

  setProject(ProjectModel project) {
    state = state.copyWith(project: project);
    getDoors();
  }

  Future<void> deleteDoor(String id) async {
    state = state.copyWith(modelState: ModelState.processing);
    await doors.doc(id).delete();
    getDoors();
  }
}
