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

    for (var link in door.caseCorrImageLinks ?? []) {
      var images = [...state.caseCorrImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(caseCorrImages: images);
      }
    }

    for (var link in door.sealImageLinks ?? []) {
      var images = [...state.sealImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(sealImages: images);
      }
    }

    for (var link in door.hingeImageLinks ?? []) {
      var images = [...state.hingeImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(hingeImages: images);
      }
    }

    for (var link in door.handleImageLinks ?? []) {
      var images = [...state.handleImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(handleImages: images);
      }
    }

    for (var link in door.closerImageLinks ?? []) {
      var images = [...state.closerImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(closerImages: images);
      }
    }

    for (var link in door.closerRegulatorImageLinks ?? []) {
      var images = [...state.closerRegulatorImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(closerRegulatorImages: images);
      }
    }
    for (var link in door.caseSealImageLinks ?? []) {
      var images = [...state.caseSealImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(caseSealImages: images);
      }
    }

    for (var link in door.bottomSealImageLinks ?? []) {
      var images = [...state.bottomSealImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(bottomSealImages: images);
      }
    }

    for (var link in door.laminateImageLinks ?? []) {
      var images = [...state.laminateImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(laminateImages: images);
      }
    }

    for (var link in door.doorstepImageLinks ?? []) {
      var images = [...state.doorstepImages];
      var data = await storageRef.child(link).getData();
      if (data != null) {
        images.add(data);
        state = state.copyWith(doorstepImages: images);
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
        var reference = await doors.add(json);
        state = state.copyWith(door: door.copyWith(id: reference.id));
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
    await uploadImage(corImageLinks, corImages);
    state = state.copyWith(door: state.door.copyWith(corrImageLinks: corImageLinks), corrImages: corImages);
  }

  Future<void> uploadCaseCorrImages() async {
    var caseCorrImageLinks = <String>[...state.door.caseCorrImageLinks ?? []];
    var caseCorrImages = [...state.caseCorrImages];
    await uploadImage(caseCorrImageLinks, caseCorrImages);
    state = state.copyWith(
        door: state.door.copyWith(caseCorrImageLinks: caseCorrImageLinks), caseCorrImages: caseCorrImages);
  }

  Future<void> uploadSealImages() async {
    var sealImageLinks = <String>[...state.door.sealImageLinks ?? []];
    var sealImages = [...state.sealImages];
    await uploadImage(sealImageLinks, sealImages);
    state = state.copyWith(door: state.door.copyWith(sealImageLinks: sealImageLinks), sealImages: sealImages);
  }

  Future<void> uploadBottomSealImages() async {
    var imageLinks = <String>[...state.door.bottomSealImageLinks ?? []];
    var images = [...state.bottomSealImages];
    await uploadImage(imageLinks, images);
    state = state.copyWith(door: state.door.copyWith(bottomSealImageLinks: imageLinks), bottomSealImages: images);
  }

  Future<void> uploadCaseSealImages() async {
    var imageLinks = <String>[...state.door.caseSealImageLinks ?? []];
    var images = [...state.caseSealImages];
    await uploadImage(imageLinks, images);
    state = state.copyWith(door: state.door.copyWith(caseSealImageLinks: imageLinks), caseSealImages: images);
  }

  Future<void> uploadCloserImages() async {
    var imageLinks = <String>[...state.door.closerImageLinks ?? []];
    var images = [...state.closerImages];
    await uploadImage(imageLinks, images);
    state = state.copyWith(door: state.door.copyWith(closerImageLinks: imageLinks), closerImages: images);
  }

  Future<void> uploadCloserRegulatorImages() async {
    var imageLinks = <String>[...state.door.closerRegulatorImageLinks ?? []];
    var images = [...state.closerRegulatorImages];
    await uploadImage(imageLinks, images);
    state =
        state.copyWith(door: state.door.copyWith(closerRegulatorImageLinks: imageLinks), closerRegulatorImages: images);
  }

  Future<void> uploadDoorstepImages() async {
    var imageLinks = <String>[...state.door.doorstepImageLinks ?? []];
    var images = [...state.doorstepImages];
    await uploadImage(imageLinks, images);
    state = state.copyWith(door: state.door.copyWith(doorstepImageLinks: imageLinks), doorstepImages: images);
  }

  Future<void> uploadHandleImages() async {
    var imageLinks = <String>[...state.door.handleImageLinks ?? []];
    var images = [...state.handleImages];
    await uploadImage(imageLinks, images);
    state = state.copyWith(door: state.door.copyWith(handleImageLinks: imageLinks), handleImages: images);
  }

  Future<void> uploadHingeImages() async {
    var imageLinks = <String>[...state.door.hingeImageLinks ?? []];
    var images = [...state.hingeImages];
    await uploadImage(imageLinks, images);
    state = state.copyWith(door: state.door.copyWith(hingeImageLinks: imageLinks), hingeImages: images);
  }

  Future<void> uploadLaminateImages() async {
    var imageLinks = <String>[...state.door.laminateImageLinks ?? []];
    var images = [...state.laminateImages];
    await uploadImage(imageLinks, images);
    state = state.copyWith(door: state.door.copyWith(laminateImageLinks: imageLinks), laminateImages: images);
  }

  clear(){
    state = DoorMaintenanceState();
  }
}
