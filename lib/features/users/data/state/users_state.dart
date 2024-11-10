import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/projects/data/models/project_model.dart';
import 'package:spec_app/features/users/data/model/user_model.dart';

part 'users_state.freezed.dart';

@freezed
abstract class UsersState with _$UsersState {
  const factory UsersState(
      {@Default([]) List<UserModel> users,
      @Default(ModelState.empty) ModelState modelState,
      @Default("") String message}) = _UserState;

  const UsersState._();
}
