import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmAlertDialog extends StatelessWidget {
  const ConfirmAlertDialog({super.key, required this.onConfirm, required this.title, required this.content, this.icon});

  final Function() onConfirm;
  final String title;
  final Widget content;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        icon: icon,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
              onPressed: () => context.pop(),
              child: Text(
                "Mégsem",
              )),
          TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                  return states.contains(WidgetState.disabled) ? null : (colorScheme.onPrimary);
                }),
                backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                  return states.contains(WidgetState.disabled) ? null : colorScheme.primary;
                }),
              ),
              onPressed: onConfirm,
              child: Text(
                "Rendben",
              ))
        ],
        content: content);
  }
}
