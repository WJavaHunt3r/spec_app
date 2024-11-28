import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class CloserIntegrityStep extends BaseStep {
  const CloserIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.closerIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(closerIntegrity: text), ref),
      ),
      if (door.closerIntegrity == null || door.closerIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadCloserImages(),
              images: ref.watch(doorMaintenanceDataProvider).closerImages,
            ),
            BaseTextFormField(
              initialValue: door.closerIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(closerIssue: text), ref),
            ),
            YesNoField(
                initialValue: door.closerFixable,
                labelText: "Javítható?",
                onChanged: (text) => updateDoor(door.copyWith(closerFixable: text), ref)),
          ],
        ),
      if (door.closerFixable == null)
        SizedBox()
      else if (door.closerFixable!)
        BaseTextFormField(
          initialValue: door.closerFix,
          maxLines: 3,
          labelText: "Hogyan?",
          onChanged: (text) => updateDoor(door.copyWith(closerFix: text), ref),
        )
      else
        BaseTextFormField(
          initialValue: door.closerChangeComment,
          labelText: "Megjegyzés pánt cserével kapcsolatban",
          maxLines: 3,
          onChanged: (text) => updateDoor(door.copyWith(closerChangeComment: text), ref),
        ),
    ];
  }
}
