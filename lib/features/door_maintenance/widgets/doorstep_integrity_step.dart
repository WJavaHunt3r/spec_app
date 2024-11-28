import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class DoorStepIntegrityStep extends BaseStep {
  const DoorStepIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.doorstepIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(doorstepIntegrity: text), ref),
      ),
      if (door.doorstepIntegrity == null || door.doorstepIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadDoorstepImages(),
              images: ref.watch(doorMaintenanceDataProvider).doorstepImages,
            ),
            BaseTextFormField(
              initialValue: door.doorstepIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(doorstepIssue: text), ref),
            )
          ],
        ),
    ];
  }
}
