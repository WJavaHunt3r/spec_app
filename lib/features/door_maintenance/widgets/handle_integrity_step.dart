import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class HandleIntegrityStep extends BaseStep {
  const HandleIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.handleIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(handleIntegrity: text), ref),
      ),
      if (door.handleIntegrity == null || door.handleIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadHandleImages(),
              images: ref.watch(doorMaintenanceDataProvider).handleImages,
            ),
            BaseTextFormField(
              initialValue: door.handleIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(handleIssue: text), ref),
            ),
            YesNoField(
                initialValue: door.handleFixable,
                labelText: "Javítható?",
                onChanged: (text) => updateDoor(door.copyWith(handleFixable: text), ref)),
          ],
        ),
      if (door.handleFixable == null)
        SizedBox()
      else if (door.handleFixable!)
        BaseTextFormField(
          initialValue: door.handleFix,
          maxLines: 3,
          labelText: "Hogyan?",
          onChanged: (text) => updateDoor(door.copyWith(handleFix: text), ref),
        )
      else
        BaseTextFormField(
          initialValue: door.handleChangeComment,
          labelText: "Megjegyzés pánt cserével kapcsolatban",
          maxLines: 3,
          onChanged: (text) => updateDoor(door.copyWith(handleChangeComment: text), ref),
        ),
    ];
  }
}
