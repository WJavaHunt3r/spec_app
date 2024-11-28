import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class HingeIntegrityStep extends BaseStep {
  const HingeIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.hingeIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(hingeIntegrity: text), ref),
      ),
      if (door.hingeIntegrity == null || door.hingeIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadHingeImages(),
              images: ref.watch(doorMaintenanceDataProvider).hingeImages,
            ),
            BaseTextFormField(
              initialValue: door.hingeIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(hingeIssue: text), ref),
            ),
            YesNoField(
                initialValue: door.hingeFixable,
                labelText: "Javítható?",
                onChanged: (text) => updateDoor(door.copyWith(hingeFixable: text), ref)),
          ],
        ),
      if (door.hingeFixable == null)
        SizedBox()
      else if (door.hingeFixable!)
        BaseTextFormField(
          initialValue: door.hingeFix,
          maxLines: 3,
          labelText: "Hogyan?",
          onChanged: (text) => updateDoor(door.copyWith(hingeFix: text), ref),
        )
      else
        BaseTextFormField(
          initialValue: door.hingeChangeComment,
          labelText: "Megjegyzés pánt cserével kapcsolatban",
          maxLines: 3,
          onChanged: (text) => updateDoor(door.copyWith(hingeChangeComment: text), ref),
        ),
    ];
  }
}
