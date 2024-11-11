import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/doors/data/models/door_model.dart';

abstract class BaseStep extends ConsumerWidget {
  const BaseStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: buildWidgets(context, ref),
    );
  }

  void updateDoor(DoorModel door, WidgetRef ref) {
    ref.watch(doorMaintenanceDataProvider.notifier).updateDoor(door);
  }

  List<Widget> buildWidgets(BuildContext context, WidgetRef ref);
}
