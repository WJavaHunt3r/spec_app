import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/widgets/base_drop_down_field.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/app/widgets/yes_no_field.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/base_step.dart';

class BasicInformationStep extends BaseStep {
  const BasicInformationStep({super.key});

  static final basicFormKey = GlobalKey<FormState>();
 
  @override
  List<Widget> buildWidgets(BuildContext context, WidgetRef ref) {
    var door = ref.watch(doorMaintenanceDataProvider).door;
    return [
      BaseTextFormField(
        initialValue: door.structureType,
        labelText: "Szerkezet típusa",
        autofocus: true,
        onChanged: (text) => updateDoor(door.copyWith(structureType: text), ref),
      ),
      BaseDropdownField<num>(
        initialValue: door.fireResistanceRating,
        labelText: "Tűzállósági rátája",
        items: [0, 30, 60, 90, 120].map((e) => DropdownMenuItem<num>(value: e, child: Text(e.toString()))).toList(),
        onChanged: (text) => updateDoor(door.copyWith(fireResistanceRating: text), ref),
      ),
      YesNoField(
          initialValue: door.escapeRoute,
          labelText: "Menekülési útvonalon helyezkedik el?",
          onChanged: (text) => updateDoor(door.copyWith(escapeRoute: text), ref)),
      YesNoField(
          initialValue: door.smokeControlFunction,
          labelText: "Füstgátló funkciót tölt-e be?",
          onChanged: (text) => updateDoor(door.copyWith(smokeControlFunction: text), ref)),
      // BaseDropdownField<num>(
      //   labelText: "Tűzállósági rátája",
      //   items: List<num>.generate(400, (index) {
      //     return index;
      //   }).map((e) => DropdownMenuItem<num>(value: e, child: Text(e.toString()))).toList(),
      //   onChanged: (text) => updateDoor(door.copyWith(structureType: text.toString()), ref),
      // ),
      BaseTextFormField<num>(
        initialValue: door.doorNumber,
        labelText: "Ajtószám",
        keyBoardType: TextInputType.number,
        onChanged: (text) => updateDoor(door.copyWith(doorNumber: num.tryParse(text)), ref),
      ),
      BaseTextFormField(
        initialValue: door.doorName,
        labelText: "Ajtó megnevezése",
        onChanged: (text) => updateDoor(door.copyWith(doorName: text), ref),
      ),
      BaseTextFormField<num>(
        initialValue: door.doorWidth,
        labelText: "Ajtó/Kapuméret - szélesség",
        keyBoardType: TextInputType.number,
        onChanged: (text) => updateDoor(door.copyWith(doorWidth: num.tryParse(text)), ref),
      ),
      BaseTextFormField<num>(
        initialValue: door.doorHeight,
        labelText: "Ajtó/Kapuméret - magasság",
        keyBoardType: TextInputType.number,
        onChanged: (text) => updateDoor(door.copyWith(doorHeight: num.tryParse(text)), ref),
      ),
      BaseDropdownField<String>(
        initialValue: door.prodYear,
        labelText: "Gyártási év",
        items: [
          "2000 előtt",
          ...List<String>.generate(DateTime.now().year - 2000 + 1, (index) {
            return (2000 + index).toString();
          })
        ].map((e) => DropdownMenuItem<String>(value: e, child: Text(e.toString()))).toList(),
        onChanged: (text) => updateDoor(door.copyWith(prodYear: text.toString()), ref),
      ),
    ];
  }
}
