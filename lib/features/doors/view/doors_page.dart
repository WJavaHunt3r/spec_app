import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/providers/user_provider.dart';
import 'package:spec_app/features/doors/providers/doors_provider.dart';
import 'package:spec_app/features/doors/view/doors_layout.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';
import 'package:spec_app/features/projects/providers/projects_provider.dart';
import 'package:spec_app/features/projects/view/project_maintenance.dart';
import 'package:spec_app/features/projects/view/projects_layout.dart';

class DoorsPage extends ConsumerWidget {
  const DoorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajtók"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // ref.read(doorsDataProvider.notifier).updateProject(ProjectModel());
        },
        label: Text("Ajtó hozzáadása"),
        icon: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: DoorsLayout(),
      ),
    );
  }
}