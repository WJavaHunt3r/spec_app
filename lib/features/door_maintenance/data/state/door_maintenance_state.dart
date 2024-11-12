import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/doors/data/models/door_model.dart';

part 'door_maintenance_state.freezed.dart';

@freezed
abstract class DoorMaintenanceState with _$DoorMaintenanceState {
  const factory DoorMaintenanceState(
      {@Default(DoorModel()) DoorModel door,
      @Default(0) int currentStep,
      MaintenanceMode? mode,
      @Default([]) List<Uint8List> corrImages,
        @Default([]) List<Uint8List> caseCorrImages,
        @Default([]) List<Uint8List> sealImages,
      @Default(ModelState.empty) ModelState modelState,
      @Default("") String message}) = _DoorMaintenanceState;

  const DoorMaintenanceState._();
}
