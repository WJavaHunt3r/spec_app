import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/maintenance_mode.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/app/widgets/confirm_alert_dialog.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/doors/data/models/door_model.dart';
import 'package:spec_app/features/doors/providers/doors_provider.dart';

class DoorsLayout extends ConsumerWidget {
  const DoorsLayout({super.key});

  static const String edit = 'Módosítás';
  static const String print = 'Nyomtatás';
  static const String delete = 'Törlés';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var doors = ref.watch(doorsDataProvider).doors;
    var project = ref.watch(doorsDataProvider).project;
    var headerStyle = TextStyle(fontSize: 18);
    return Stack(
      children: [
        RefreshIndicator(
            onRefresh: () => ref.read(doorsDataProvider.notifier).getDoors(),
            child: Column(
              children: [
                Card(
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
                ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                          indent: 20,
                          endIndent: 20,
                        ),
                    itemCount: doors.length,
                    itemBuilder: (context, index) {
                      var current = doors[index];
                      return ListTile(
                        leading: Text(convertNull(current.doorNumber)),
                        title: Text(
                            "${current.doorName} (${convertNull(current.doorWidth)} x ${convertNull(current.doorHeight)})"),
                        subtitle:
                            Text("${current.prodYear} - ${current.fireResistanceRating} - ${current.structureType}"),
                        trailing: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, color: Colors.black),
                            onSelected: (value) {
                              handleSelection(ref, value, context, project.id, current);
                            },
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            itemBuilder: (BuildContext buildContext) {
                              return {edit, delete, print}.map((String choice) {
                                return PopupMenuItem<String>(value: choice, child: Text(choice));
                              }).toList();
                            }),
                        onTap: () {
                          onTap(ref, context, current, project.id!);
                        },
                      );
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

  void onTap(WidgetRef ref, BuildContext context, DoorModel door, String id) {
    ref.read(doorMaintenanceDataProvider.notifier).setDoor(door, MaintenanceMode.edit);
    context.push("/projects/$id/door");
  }

  String convertNull(dynamic value) => value == null ? "" : value.toString();

  void handleSelection(WidgetRef ref, String value, BuildContext context, String? id, DoorModel door) {
    switch (value) {
      case edit:
        onTap(ref, context, door, id!);
        break;
      case delete:
        showDialog(
            context: context,
            builder: (builder) => ConfirmAlertDialog(
                  onConfirm: () => context.pop(true),
                  title: "Törlés",
                  content: Text("Biztosan törlöd az ajtót?", textAlign: TextAlign.center),
                ));
        break;
      case print:
        break;
    }
  }
}
