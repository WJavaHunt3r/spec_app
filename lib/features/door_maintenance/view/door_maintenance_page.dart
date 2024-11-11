import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/providers/user_provider.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/view/door_maintenance_layout.dart';
import 'package:spec_app/features/doors/providers/doors_provider.dart';
import 'package:spec_app/features/doors/view/doors_layout.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';
import 'package:spec_app/features/projects/providers/projects_provider.dart';
import 'package:spec_app/features/projects/view/project_maintenance.dart';
import 'package:spec_app/features/projects/view/projects_layout.dart';

class DoorMaintenancePage extends ConsumerWidget {
  const DoorMaintenancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mode = ref.watch(doorMaintenanceDataProvider).mode;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajtó ${mode == MaintenanceMode.edit ? "szerkesztése" : "létrehozása"}"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: DoorMaintenanceLayout(),
      ),
    );
  }
}