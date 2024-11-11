import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/doors/providers/doors_provider.dart';

class DoorsLayout extends ConsumerWidget {
  const DoorsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var doors = ref.watch(doorsDataProvider).doors;
    var project = ref.watch(doorsDataProvider).project;
    var headerStyle = TextStyle(fontSize: 18, color: Colors.white);
    return Stack(
      children: [
        RefreshIndicator(
            onRefresh: () => ref.read(doorsDataProvider.notifier).getDoors(),
            child: Column(
              children: [
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Helyszín:",
                              style: headerStyle,
                            ),
                            Text(project!.address.toString(), style: headerStyle)
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Üzemben tartó:", style: headerStyle),
                            Text(project.maintainer.toString(), style: headerStyle)
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ajtók száma:", style: headerStyle),
                            Text(ref.watch(doorsDataProvider).doors.length.toString(), style: headerStyle)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: doors.length,
                    itemBuilder: (context, index) {
                      var current = doors[index];
                      return Card(
                          child: ListTile(
                        leading: Text(current.doorNumber.toString()),
                        title: Text("${current.doorName} (${current.doorWidth} x ${current.doorHeight})"),
                        subtitle:
                            Text("${current.prodYear} - ${current.fireResistanceRating} - ${current.structureType}"),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                          ref.read(doorMaintenanceDataProvider.notifier).setDoor(current, MaintenanceMode.edit);
                          context.push("/projects/${project.id}/door");
                        },
                      ));
                    }),
              ],
            )),
        ref.watch(doorsDataProvider).modelState == ModelState.processing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox()
      ],
    );
  }
}
