import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/basic_information_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/corrosion_integrity_step.dart';

class DoorMaintenanceLayout extends ConsumerWidget {
  DoorMaintenanceLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentStep = ref.watch(doorMaintenanceDataProvider).currentStep;
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Stepper(
            steps: steps,
            type: StepperType.vertical,
            currentStep: currentStep,
            onStepContinue: currentStep == steps.length - 1
                ? null
                : () => ref.read(doorMaintenanceDataProvider.notifier).setStep(currentStep + 1),
            onStepCancel: () => currentStep == 0
                ? context.pop()
                : ref.read(doorMaintenanceDataProvider.notifier).setStep(currentStep - 1),
            onStepTapped: (step) => ref.read(doorMaintenanceDataProvider.notifier).setStep(step),
          ),
        ));
  }

  final steps = [
    Step(
        content: BasicInformationStep(),
        title: Text(
          "Alap információk",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: CorrosionIntegrityStep(),
        title: Text(
          "Ajtólap mechanikai és korróziós épsége",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ))
  ];
}