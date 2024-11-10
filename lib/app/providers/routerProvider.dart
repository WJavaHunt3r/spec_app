import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/providers/user_provider.dart';
import 'package:spec_app/features/projects/view/projects_page.dart';
import 'package:spec_app/features/users/data/model/user_model.dart';

import '../../features/login/view/login_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      initialLocation: "/",
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) => ProjectsPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) => ProjectsPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginPage();
          },
        ),
        // GoRoute(
        //     path: '/admin',
        //     pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage(child: AdminPage()),
        //     routes: [
        //       GoRoute(path: "activities", builder: (BuildContext context, GoRouterState state) => ActivitiesPage()),
        //       GoRoute(
        //           path: "transactions",
        //           builder: (BuildContext context, GoRouterState state) => TransactionsPage(),
        //           routes: [
        //             GoRoute(
        //               path: ':id',
        //               builder: (BuildContext context, GoRouterState state) {
        //                 return TransactionItemsPage();
        //               },
        //             ),
        //           ])
        //     ]),
      ],
      redirect: (BuildContext context, GoRouterState state) async {
        UserModel? user = ref.read(userDataProvider);
        // try {
        //   user ??= await ref.read(loginDataProvider.notifier).loginWithSavedData();
        // } on DioException catch (e) {
        //   user = null;
        // }
        if (user == null) {
          return "/login";
        }

        return state.matchedLocation;
      });
});
