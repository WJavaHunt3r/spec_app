import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';

part 'projects_state.freezed.dart';

@freezed
abstract class ProjectsState with _$ProjectsState {
  const factory ProjectsState(
      {@Default([]) List<ProjectModel> projects,
      ProjectModel? selectedProject,
      @Default(ModelState.empty) ModelState modelState,
      @Default("") String message}) = _ProjectsState;

  const ProjectsState._();
}
