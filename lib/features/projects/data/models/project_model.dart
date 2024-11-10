import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_model.freezed.dart';

part 'project_model.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel(
      {String? id,
      String? maintainer,
      String? address,
      String? contractNr,
      String? operator,
      String? certNumber}) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);


}
