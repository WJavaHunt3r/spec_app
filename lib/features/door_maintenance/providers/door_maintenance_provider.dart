import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/door_maintenance/data/state/door_maintenance_state.dart';
import 'package:spec_app/features/doors/data/models/door_model.dart';

final doorMaintenanceDataProvider =
    StateNotifierProvider<DoorMaintenanceDataNotifier, DoorMaintenanceState>((ref) => DoorMaintenanceDataNotifier());

class DoorMaintenanceDataNotifier extends StateNotifier<DoorMaintenanceState> {
  DoorMaintenanceDataNotifier() : super(DoorMaintenanceState()) {
    doors = FirebaseFirestore.instance.collection('doors');
    storageRef = FirebaseStorage.instance.ref();
  }

  late final CollectionReference doors;
  late final Reference storageRef;

  Future<void> setImages() async {
    var door = state.door;
    for (var link in door.corrImageLinks ?? []) {
      var images = [...state.corrImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(corrImages: images);
      }
    }
  }

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

  Future<void> setDoor(DoorModel door, [MaintenanceMode? mode]) async {
    state = state.copyWith(door: door, mode: mode);
    setImages();
  }

  updateDoor(DoorModel door) {
    state = state.copyWith(door: door);
  }

  void setStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  Future<void> uploadImage(List<String> imageLinks, List<Uint8List> stateImages) async {
    try {
      FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );

      if (pickedFile != null) {
        for (var file in pickedFile.files) {
          var filePath = "${state.door.projectId!}/${file.name}";
          var imgRef = storageRef.child(filePath);
          var task = imgRef.putData(file.bytes!);

          imageLinks.add(filePath);
          // var images = [...state.corrImages];
          stateImages.add(file.bytes!);
        }
      }
    } catch (e) {
      state = state.copyWith(modelState: ModelState.error, message: "Not supported: ${e.toString()}");
    }
  }

  Future<void> uploadCorrImages() async {
    var corImageLinks = <String>[...state.door.corrImageLinks ?? []];
    var corImages = [...state.corrImages];
    uploadImage(corImageLinks, corImages);
    state = state.copyWith(door: state.door.copyWith(corrImageLinks: corImageLinks), corrImages: corImages);
  }

  Future<void> uploadCaseCorrImages() async {
    var caseCorrImageLinks = <String>[...state.door.caseCorrImageLinks ?? []];
    var caseCorrImages = [...state.caseCorrImages];
    uploadImage(caseCorrImageLinks, caseCorrImages);
    state = state.copyWith(
        door: state.door.copyWith(caseCorrImageLinks: caseCorrImageLinks), caseCorrImages: caseCorrImages);
  }

  Future<void> uploadSealImages() async {
    var sealImageLinks = <String>[...state.door.sealImageLinks ?? []];
    var sealImages = [...state.sealImages];
    uploadImage(sealImageLinks, sealImages);
    state = state.copyWith(door: state.door.copyWith(sealImageLinks: sealImageLinks), sealImages: sealImages);
  }
}
