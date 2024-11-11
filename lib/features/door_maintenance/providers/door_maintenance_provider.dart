import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/door_maintenance/data/state/door_maintenance_state.dart';
import 'package:spec_app/features/doors/data/models/door_model.dart';

final doorMaintenanceDataProvider =
    StateNotifierProvider.autoDispose<DoorMaintenanceDataNotifier, DoorMaintenanceState>(
        (ref) => DoorMaintenanceDataNotifier());

class DoorMaintenanceDataNotifier extends StateNotifier<DoorMaintenanceState> {
  DoorMaintenanceDataNotifier() : super(DoorMaintenanceState()) {
    doors = FirebaseFirestore.instance.collection('doors');
    FirebaseStorage.instance.ref();
  }

  late final CollectionReference doors;
  late final Reference storageRef;

  Future<void> saveProject() async {
    state = state.copyWith(modelState: ModelState.processing);
    var mode = state.mode;
    var door = state.door;
    try {
      var json = door.toJson();
      if (mode == MaintenanceMode.create) {
        await doors.add(json);
      } else if (mode == MaintenanceMode.edit) {
        await doors.doc(door.id).set(door.toJson());
      }
      state = state.copyWith(modelState: ModelState.success, message: "Ajtó sikeresen mentve");
    } on Exception {
      state = state.copyWith(modelState: ModelState.error, message: "Hiba történt a mentés során!");
    }
  }

  setDoor(DoorModel project, [MaintenanceMode? mode]) {
    state = state.copyWith(door: project, mode: mode);
  }

  updateDoor(DoorModel project) {
    state = state.copyWith(door: project);
  }

  void setStep(int step) {
    state = state.copyWith(currentStep: step);
  }
}
