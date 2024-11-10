import 'package:flutter/material.dart';

class BaseTextFormField extends StatelessWidget {
  const BaseTextFormField(
      {super.key,
      this.initialValue,
      required this.labelText,
      this.enabled = true,
      required this.onChanged,
      this.textAlign = TextAlign.left,
      this.keyBoardType = TextInputType.text,
      this.autofocus = false});

  final String? initialValue;
  final String labelText;
  final bool enabled;
  final bool autofocus;
  final TextAlign textAlign;
  final TextInputType keyBoardType;
  final Function(String text) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        enabled: enabled,
        textAlign: textAlign,
        keyboardType: keyBoardType,
        initialValue: initialValue,
        autofocus: autofocus,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 15)),
        onChanged: (String text) => onChanged(text),
      ),
    );
  }
}
