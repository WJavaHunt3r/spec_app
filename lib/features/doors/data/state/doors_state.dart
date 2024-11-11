import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/doors/data/models/door_model.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';

part 'doors_state.freezed.dart';

@freezed
abstract class DoorsState with _$DoorsState {
  const factory DoorsState(
      {@Default([]) List<DoorModel> doors,
      ProjectModel? project,
      @Default(ModelState.empty) ModelState modelState,
      @Default("") String message}) = _DoorsState;

  const DoorsState._();
}
