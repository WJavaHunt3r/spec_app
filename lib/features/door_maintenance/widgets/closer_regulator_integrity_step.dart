import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class CloserRegulatorIntegrityStep extends BaseStep {
  const CloserRegulatorIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.closerRegulatorIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(closerRegulatorIntegrity: text), ref),
      ),
      if (door.closerRegulatorIntegrity == null || door.closerRegulatorIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadCloserRegulatorImages(),
              images: ref.watch(doorMaintenanceDataProvider).closerRegulatorImages,
            ),
            BaseTextFormField(
              initialValue: door.closerRegulatorIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(closerRegulatorIssue: text), ref),
            ),
            YesNoField(
                initialValue: door.closerRegulatorFixable,
                labelText: "Javítható?",
                onChanged: (text) => updateDoor(door.copyWith(closerRegulatorFixable: text), ref)),
          ],
        ),
      if (door.closerRegulatorFixable == null)
        SizedBox()
      else if (door.closerRegulatorFixable!)
        BaseTextFormField(
          initialValue: door.closerRegulatorFix,
          maxLines: 3,
          labelText: "Hogyan?",
          onChanged: (text) => updateDoor(door.copyWith(closerRegulatorFix: text), ref),
        )
      else
        BaseTextFormField(
          initialValue: door.closerRegulatorChangeComment,
          labelText: "Megjegyzés pánt cserével kapcsolatban",
          maxLines: 3,
          onChanged: (text) => updateDoor(door.copyWith(closerRegulatorChangeComment: text), ref),
        ),
    ];
  }
}
