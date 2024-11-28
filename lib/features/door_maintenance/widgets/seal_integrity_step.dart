import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class SealIntegrityStep extends BaseStep {
  const SealIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.sealIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(sealIntegrity: text), ref),
      ),
      if (door.sealIntegrity == null || door.sealIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadSealImages(),
              images: ref.watch(doorMaintenanceDataProvider).sealImages,
            ),
            BaseTextFormField(
              initialValue: door.sealIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(sealIssue: text), ref),
            ),
            YesNoField(
                initialValue: door.sealFixable,
                labelText: "Javítható?",
                onChanged: (text) => updateDoor(door.copyWith(sealFixable: text), ref)),
          ],
        ),
      if (door.sealFixable == null)
        SizedBox()
      else if (door.sealFixable!)
        BaseTextFormField(
          initialValue: door.sealFix,
          maxLines: 3,
          labelText: "Hogyan?",
          onChanged: (text) => updateDoor(door.copyWith(sealFix: text), ref),
        )
      else
        Column(
          children: [
            BaseTextFormField<num>(
              initialValue: door.sealDepth,
              labelText: "Zár mélyésge",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(sealDepth: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.sealHandleLockDistance,
              labelText: "Kilincs-zártángely távolság ",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(sealHandleLockDistance: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.sealLockPlateWidth,
              labelText: "Zárlap szélessége",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(sealLockPlateWidth: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.sealLockPlateLength,
              labelText: "Zárlap hosszúsága",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(sealLockPlateLength: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.sealLockPlateScrewAxis,
              labelText: "Zárlap csavarjainak tengelytávolsága",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(sealLockPlateScrewAxis: num.tryParse(text)), ref),
            ),
          ],
        ),
    ];
  }
}
