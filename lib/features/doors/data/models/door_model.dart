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
      num? corrIntExternalHeight,
      OkNotOk? caseCorrosionIntegrity,
      List<String>? caseCorrImageLinks,
      String? caseCorrIntIssue,
      bool? caseCorrIntFixable,
      String? caseCorrIntFix,
      num? caseCorrIntTBMWidth,
      num? caseCorrIntTBMHeight,
      num? caseCorrIntWallWidth,
      num? caseCorrIntOpeningHeight,
      num? caseCorrIntOpeningWidth,
      String? caseCorrIntMaterial,
      String? caseCorrIntComment,
      String? caseCorrIntDoorColor,
      String? caseCorrIntWallColor,
      String? caseCorrIntCaseType,
      List<String>? caseCorrIntCaseTypeImageLinks,
      num? caseCorrIntKickPlateWidth,
      num? caseCorrIntKickPlateHeight,
      String? caseCorrIntHandleType,
      String? caseCorrIntHandleMaterial,
      String? caseCorrIntHandleColor,
      String? caseCorrIntHandleForm,
      String? caseCorrIntHandleLockAccess,
      String? caseCorrIntCloserType,
      String? caseCorrIntCloserRegulatorType,
      String? caseCorrIntShipping,
      String? caseCorrIntRubbleShipping,
      String? caseCorrIntOther,
      OkNotOk? sealIntegrity,
      List<String>? sealImageLinks,
      String? sealIssue,
      bool? sealFixable,
      String? sealFix,
      num? sealDepth,
      num? sealHandleLockDistance,
      num? sealLockPlateWidth,
      num? sealLockPlateLength,
      num? sealLockPlateScrewAxis}) = _DoorModel;

  factory DoorModel.fromJson(Map<String, dynamic> json) => _$DoorModelFromJson(json);
}
