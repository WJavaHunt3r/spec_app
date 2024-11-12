import 'package:flutter/material.dart';
import 'package:spec_app/app/widgets/base_drop_down_field.dart';

class YesNoField extends BaseDropdownField<bool> {
  YesNoField({super.key, required super.labelText, required super.onChanged, super.initialValue})
      : super(
            items: [true, false]
                .map((e) => DropdownMenuItem<bool>(
                      value: e,
                      child: Text(e ? "Igen" : "Nem"),
                    ))
                .toList());
}
