import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_drop_down_field.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/image_uploader.dart';
import 'package:spec_app/app/widgets/ok_not_ok_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class CaseCorrosionIntegrityStep extends BaseStep {
  const CaseCorrosionIntegrityStep({super.key});

  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      IsOkField(
        initialValue: door.caseCorrosionIntegrity,
        labelText: "Rendben van?",
        onChanged: (text) => updateDoor(door.copyWith(caseCorrosionIntegrity: text), ref),
      ),
      if (door.caseCorrosionIntegrity == null || door.caseCorrosionIntegrity == OkNotOk.ok)
        SizedBox()
      else
        Column(
          children: [
            ImageUploader(
              onPressed: () => ref.watch(doorMaintenanceDataProvider.notifier).uploadCaseCorrImages(),
              images: ref.watch(doorMaintenanceDataProvider).caseCorrImages,
            ),
            BaseTextFormField(
              initialValue: door.caseCorrIntIssue,
              labelText: "Mi a hiba?",
              maxLines: 3,
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntIssue: text), ref),
            ),
            YesNoField(
                initialValue: door.caseCorrIntFixable,
                labelText: "Javítható?",
                onChanged: (text) => updateDoor(door.copyWith(caseCorrIntFixable: text), ref)),
          ],
        ),
      if (door.caseCorrIntFixable == null)
        SizedBox()
      else if (door.caseCorrIntFixable!)
        BaseTextFormField(
          initialValue: door.caseCorrIntFix,
          maxLines: 3,
          labelText: "Hogyan?",
          onChanged: (text) => updateDoor(door.copyWith(caseCorrIntFix: text), ref),
        )
      else
        Column(
          children: [
            BaseTextFormField<num>(
              initialValue: door.caseCorrIntTBMWidth,
              labelText: "TBM szélessége",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntTBMWidth: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.caseCorrIntTBMHeight,
              labelText: "TBM magassága",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntTBMHeight: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.caseCorrIntWallWidth,
              labelText: "Fal vastagsága",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntWallWidth: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.caseCorrIntOpeningWidth,
              labelText: "Nyílásméret szélesség",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntOpeningWidth: num.tryParse(text)), ref),
            ),
            BaseTextFormField<num>(
              initialValue: door.caseCorrIntOpeningHeight,
              labelText: "Nyílásméret magasság",
              keyBoardType: TextInputType.number,
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntOpeningHeight: num.tryParse(text)), ref),
            ),
            BaseDropdownField<String>(
              initialValue: door.caseCorrIntMaterial,
              labelText: "Fal/fogadószerkezet anyaga",
              items: ["beton", "acél", "gipszkarton", "szendvicspanel"]
                  .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntMaterial: text), ref),
            ),
            BaseTextFormField(
              initialValue: door.caseCorrIntComment,
              maxLines: 3,
              labelText: "Megjegyzés a beépítéssel kapcsolatban!",
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntComment: text), ref),
            ),
            BaseDropdownField<String>(
              initialValue: door.caseCorrIntCloserType,
              labelText: "Csukó(Fokozott Igénybevétel IGEN/NEM)",
              items: ["Még", "Nem", "Tudom"].map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntCloserType: text), ref),
            ),
            BaseDropdownField<String>(
              initialValue: door.caseCorrIntCloserRegulatorType,
              labelText: "Csukássorrend szabályozó fajta",
              items: ["Még", "Nem", "Tudom"].map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntCloserRegulatorType: text), ref),
            ),
            BaseTextFormField(
              initialValue: door.caseCorrIntShipping,
              labelText: "Kiszerelt ajtó elszállítása szükséges?",
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntShipping: text), ref),
            ),
            BaseTextFormField(
              initialValue: door.caseCorrIntRubbleShipping,
              labelText: "Sitt elszállítás útvonala",
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntRubbleShipping: text), ref),
            ),
            BaseTextFormField(
              initialValue: door.caseCorrIntOther,
              labelText: "Kiszerelt ajtó elszállítása szükséges?",
              onChanged: (text) => updateDoor(door.copyWith(caseCorrIntRubbleShipping: text), ref),
            ),
          ],
        ),
    ];
  }
}
