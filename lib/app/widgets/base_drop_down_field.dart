import 'package:flutter/material.dart';

class BaseDropdownField<T> extends StatelessWidget {
  const BaseDropdownField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    required this.items,
    required this.onChanged,
    this.initialValue
  });

  final String labelText;
  final Widget? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final Function(T? value) onChanged;
  final T? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: DropdownButtonFormField<T>(
        value: initialValue,
        items: items,
        onChanged: (text) => onChanged(text),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
          labelText: labelText,
          prefixIcon: prefixIcon,
        ),
        borderRadius: BorderRadius.circular(4),
        dropdownColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
