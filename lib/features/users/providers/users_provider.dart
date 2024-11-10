import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/features/users/data/model/user_model.dart';
import 'package:spec_app/features/users/data/state/users_state.dart';

final usersDataProvider = StateNotifierProvider<UsersDataNotifier, UsersState>((ref) => UsersDataNotifier());

class UsersDataNotifier extends StateNotifier<UsersState> {
  UsersDataNotifier() : super(UsersState()) {
    users = FirebaseFirestore.instance.collection('users');
    getUsers();
  }

  late final CollectionReference users;

  Future<void> getUsers() async {
    state = state.copyWith(modelState: ModelState.processing);
    try {
      var projectList = await getUsersFromDb();
      state = state.copyWith(users: projectList, modelState: ModelState.success);
    } catch (e) {
      state = state.copyWith(modelState: ModelState.error, message: e.toString());
    }
  }

  Future<List<UserModel>> getUsersFromDb() async {
    try {
      List<UserModel> projectList = [];
      var values =
          await users.get().catchError((error) => state = state.copyWith(modelState: ModelState.error, message: error));

      for (var v in values.docs) {
        Map<String, dynamic> data = v.data()! as Map<String, dynamic>;
        var project = UserModel.fromJson(data);
        var idUser = project.copyWith(id: v.id);
        projectList.add(idUser);
      }

      return projectList;
    } on Exception {
      throw Exception("Hiba történt");
    }
  }

// updateUser(UserModel project) {
//   state = state.copyWith(selectedUser: project);
// }
}
