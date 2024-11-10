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
      this.autofocus = false,
      this.textInputAction = TextInputAction.next,
      this.validator,
      this.onFieldSubmitted});

  final String? initialValue;
  final String labelText;
  final bool enabled;
  final bool autofocus;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final TextInputType keyBoardType;
  final Function(String text) onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        enabled: enabled,
        textAlign: textAlign,
        keyboardType: keyBoardType,
        initialValue: initialValue,
        textInputAction: textInputAction,
        validator: validator == null ? null : (text) => validator!(text),
        autofocus: autofocus,
        onFieldSubmitted: onFieldSubmitted != null ? (text) => onFieldSubmitted!(text) : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 15)),
        onChanged: (String text) => onChanged(text),
      ),
    );
  }
}
