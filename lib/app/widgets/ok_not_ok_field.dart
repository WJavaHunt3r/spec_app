import 'package:flutter/material.dart';
import 'package:spec_app/app/enums/ok_not_ok.dart';
import 'package:spec_app/app/widgets/base_drop_down_field.dart';

class IsOkField extends BaseDropdownField<OkNotOk> {
  IsOkField({super.key, required super.labelText, required super.onChanged})
      : super(
            items: OkNotOk.values
                .map((e) => DropdownMenuItem<OkNotOk>(
                      value: e,
                      child: Text(e == OkNotOk.ok ? "Ok" : "Nem Ok"),
                    ))
                .toList());
}
