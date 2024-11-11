import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/app/providers/user_provider.dart';
import 'package:spec_app/features/login/data/login_state.dart';
import 'package:spec_app/features/users/data/model/user_model.dart';
import 'package:spec_app/features/users/providers/users_provider.dart';

final loginDataProvider = StateNotifierProvider.autoDispose<LoginDataNotifier, LoginState>(
    (ref) => LoginDataNotifier(ref.read(usersDataProvider.notifier), ref.read(userDataProvider.notifier)));

class LoginDataNotifier extends StateNotifier<LoginState> {
  LoginDataNotifier(this.userRepo, this.userSession) : super(LoginState()) {
    getUsers();
  }

  late final CollectionReference projects;
  final UsersDataNotifier userRepo;
  final UserDataNotifier userSession;

  Future<void> getUsers() async {
    state = state.copyWith(modelState: ModelState.processing);

    try {
      var users = await userRepo.getUsersFromDb();
      state = state.copyWith(users: users, modelState: ModelState.success);
    } catch (e) {
      state = state.copyWith(message: e.toString(), modelState: ModelState.error);
    }
  }

  Future<void> login() async {
    state = state.copyWith(modelState: ModelState.processing);

    if (state.username != state.password || (state.password.isEmpty || state.username.isEmpty)) {
      state = state.copyWith(modelState: ModelState.error, message: "Hibás jelszó");
    } else {
      await userSession.setUser(state.selectedUser);
      state = state.copyWith(modelState: ModelState.success);
    }
  }

  setUser(UserModel u) {
    state = state.copyWith(username: u.username!,selectedUser: u, modelState: ModelState.empty);
  }

  setPassword(String password) {
    state = state.copyWith(password: password, modelState: ModelState.empty);
  }
}
