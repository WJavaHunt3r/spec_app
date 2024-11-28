import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class CorrosionIntegrityStep extends BaseStep {
  const CorrosionIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.corrosionIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(corrosionIntegrity: text), ref),
      ),
      if (door.corrosionIntegrity == null || door.corrosionIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadCorrImages(),
              images: ref.watch(doorMaintenanceDataProvider).corrImages,
            ),
            BaseTextFormField(
              initialValue: door.corrIntIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(corrIntIssue: text), ref),
            ),
            YesNoField(
                initialValue: door.corrIntFixable,
                labelText: "Javítható?",
                onChanged: (text) => updateDoor(door.copyWith(corrIntFixable: text), ref)),
          ],
        ),
      if (door.corrIntFixable == null)
        SizedBox()
      else if (door.corrIntFixable!)
        BaseTextFormField(
          initialValue: door.corrIntFix,
          maxLines: 3,
          labelText: "Hogyan?",
          onChanged: (text) => updateDoor(door.copyWith(corrIntFix: text), ref),
        )
      else
        Column(
          children: [
            BaseTextFormField<num>(
              initialValue: door.corrIntTBMWidth,
              labelText: "TBM szélessége",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(corrIntTBMWidth: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.corrIntTBMHeight,
              labelText: "TBM magassága",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(corrIntTBMHeight: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.corrIntRebateWidth,
              labelText: "Lap falcméret szélessége",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(corrIntRebateWidth: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.corrIntRebateHeight,
              labelText: "Lap falcméret magasság",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(corrIntRebateHeight: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.corrIntExternalWidth,
              labelText: "Lap külméret szélessége",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(corrIntExternalWidth: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.corrIntExternalHeight,
              labelText: "Lap külméret magasság",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(corrIntExternalHeight: num.tryParse(text)), ref),
            ),
          ],
        ),
    ];
  }
}
