import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/features/door_maintenance/providers/door_maintenance_provider.dart';
import 'package:spec_app/features/door_maintenance/widgets/basic_information_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/bottom_sealing_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/case_corrosion_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/case_sealing_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/closer_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/closer_regulator_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/corrosion_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/doorstep_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/handle_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/hinge_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/laminate_integrity_step.dart';
import 'package:spec_app/features/door_maintenance/widgets/seal_integrity_step.dart';

class DoorMaintenanceLayout extends ConsumerWidget {
  DoorMaintenanceLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentStep = ref.watch(doorMaintenanceDataProvider).currentStep;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Stepper(
            steps: steps,
            type: StepperType.vertical,
            controlsBuilder: (BuildContext context, details) {
              return Row(
                children: <Widget>[
                  TextButton(
                      onPressed: details.onStepContinue,
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                          return states.contains(WidgetState.disabled) ? null : (colorScheme.onPrimary);
                        }),
                        backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                          return states.contains(WidgetState.disabled) ? null : colorScheme.primary;
                        }),
                        // padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(buttonPadding),
                        // shape: const WidgetStatePropertyAll<OutlinedBorder>(buttonShape),
                      ),
                      child: Text(currentStep != steps.length - 1 ? 'Következő' : "Mentés és kilépés")),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 8.0),
                    child: TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Vissza'),
                    ),
                  ),
                ],
              );
            },
            currentStep: currentStep,
            onStepContinue: () {
              if (currentStep != steps.length - 1) {
                ref.read(doorMaintenanceDataProvider.notifier).setStep(currentStep + 1);
              }
              ref.read(doorMaintenanceDataProvider.notifier).saveProject();
              if (currentStep == steps.length - 1) {
                ref.read(doorMaintenanceDataProvider.notifier).clear();
                context.pop();
              }
            },
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
        )),
    Step(
        content: CaseCorrosionIntegrityStep(),
        title: Text(
          "Tok mechanikai és korróziós épsége",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: SealIntegrityStep(),
        title: Text(
          "Zár állapota/működése",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: HingeIntegrityStep(),
        title: Text(
          "Pánt állapota/működése",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: HandleIntegrityStep(),
        title: Text(
          "Pánt állapota/működése",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: CloserIntegrityStep(),
        title: Text(
          "Ajtócsukó állapota/működése",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: CloserRegulatorIntegrityStep(),
        title: Text(
          "Sorrendszabályozó állapota/működése",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: CaseSealingIntegrityStep(),
        title: Text(
          "Toktömítés épsége, megléte",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: LaminateIntegrityStep(),
        title: Text(
          "Hőre habosodó laminátok épsége, megléte",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: BottomSealingIntegrityStep(),
        title: Text(
          "Alsó tömítés épsége/Süllyeszthető padlótömítés",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        )),
    Step(
        content: DoorStepIntegrityStep(),
        title: Text(
          "Automata/gumiprofilos fix küszöb épsége",
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ))
  ];
}
