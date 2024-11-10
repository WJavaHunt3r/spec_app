import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/login/data/login_state.dart';
import 'package:spec_app/features/users/providers/users_provider.dart';

final loginDataProvider = StateNotifierProvider<LoginDataNotifier, LoginState>(
    (ref) => LoginDataNotifier(ref.watch(usersDataProvider.notifier)));

class LoginDataNotifier extends StateNotifier<LoginState> {
  LoginDataNotifier(this.userRepo) : super(LoginState()) {
    getLogin();
  }

  late final CollectionReference projects;
  final UsersDataNotifier userRepo;

  Future<void> getLogin() async {
    state = state.copyWith(modelState: ModelState.processing);

    try {
      var users = await userRepo.getUsersFromDb();
      state = state.copyWith(users: users, modelState: ModelState.success);
    } catch (e) {
      state = state.copyWith(message: e.toString(), modelState: ModelState.error);
    }
  }

  setUsername(String username) {
    state = state.copyWith(username: username);
  }

  setPassword(String password) {
    state = state.copyWith(password: password);
  }
}
