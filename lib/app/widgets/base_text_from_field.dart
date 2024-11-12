import 'package:flutter/material.dart';

class BaseTextFormField<T> extends StatefulWidget {
  const BaseTextFormField(
      {super.key,
      this.initialValue,
      required this.labelText,
      this.enabled = true,
      this.onChanged,
      this.textAlign = TextAlign.left,
      this.keyBoardType = TextInputType.text,
      this.autofocus = false,
      this.controller,
      this.autofillHints,
      this.focusNode,
      this.textStyle,
      this.textInputAction = TextInputAction.next,
      this.obscureText = false,
      this.validator,
      this.fillColor,
      this.onFieldSubmitted,
      this.isPasswordField = false,
      this.prefixIcon,
      this.errorText});

  final T? initialValue;
  final String labelText;
  final String? errorText;
  final bool enabled;
  final bool autofocus;
  final TextAlign textAlign;
  final TextInputType keyBoardType;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final TextInputAction textInputAction;
  final Color? fillColor;
  final bool obscureText;
  final bool isPasswordField;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function(String text)? onChanged;
  final Function(String text)? onFieldSubmitted;

  @override
  State<StatefulWidget> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void obscuredChanged() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: TextFormField(
        autofillHints: widget.autofillHints,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        textAlign: widget.textAlign,
        controller: widget.controller,
        keyboardType: widget.keyBoardType,
        initialValue: widget.initialValue == null ? "" : widget.initialValue.toString(),
        autofocus: widget.autofocus,
        textInputAction: widget.textInputAction,
        obscureText: _isObscured,
        decoration: InputDecoration(
            labelText: widget.labelText,
            fillColor: widget.fillColor,
            errorText: widget.errorText,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            labelStyle: widget.textStyle ?? TextStyle(fontSize: 15),
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    onPressed: () => obscuredChanged(),
                    icon: _isObscured ? Icon(Icons.visibility) : Icon(Icons.visibility_off))
                : null,
            prefixIcon: widget.prefixIcon),
        onChanged: widget.onChanged != null ? (String text) => widget.onChanged!(text) : null,
        onFieldSubmitted: widget.onFieldSubmitted != null ? (String text) => widget.onFieldSubmitted!(text) : null,
        validator: widget.validator == null ? null : (String? text) => widget.validator!(text),
      ),
    );
  }
}
