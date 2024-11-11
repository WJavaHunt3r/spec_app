import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';

part 'door_model.freezed.dart';

part 'door_model.g.dart';

@freezed
class DoorModel with _$DoorModel {
  const factory DoorModel(
      {String? id,
      String? projectId,
      String? structureType,
      num? fireResistanceRating,
      bool? escapeRoute,
      bool? smokeControlFunction,
      num? doorNumber,
      String? doorName,
      num? doorWidth,
      num? doorHeight,
      String? prodYear,
      OkNotOk? corrosionIntegrity,
      List<String>? corrImageLinks,
      String? corrIntIssue,
      bool? corrIntFixable,
      String? corrIntFix,
      num? corrIntTBMWidth,
      num? corrIntTBMHeight,
      num? corrIntRebateWidth,
      num? corrIntRebateHeight,
      num? corrIntExternalWidth,
      num? corrIntExternalHeight}) = _DoorModel;

  factory DoorModel.fromJson(Map<String, dynamic> json) => _$DoorModelFromJson(json);
}
