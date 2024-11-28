import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class BottomSealingIntegrityStep extends BaseStep {
  const BottomSealingIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.bottomSealIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(bottomSealIntegrity: text), ref),
      ),
      if (door.bottomSealIntegrity == null || door.bottomSealIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadBottomSealImages(),
              images: ref.watch(doorMaintenanceDataProvider).bottomSealImages,
            ),
            BaseTextFormField(
              initialValue: door.bottomSealIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(bottomSealIssue: text), ref),
            )
          ],
        ),
    ];
  }
}
