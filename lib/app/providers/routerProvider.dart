import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      initialLocation: "/",
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage(child: ProjectsPage()),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage(child: ProjectsPage()),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return  LoginPage();
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
        try {
          user ??= await ref.read(loginDataProvider.notifier).loginWithSavedData();
        } on DioException catch (e) {
          user = null;
        }
        if (user == null && state.matchedLocation.contains("/login")) {
            return "/login";
        }

        if (state.matchedLocation.contains("/admin/") && !user.isAdmin()) {
          return "/home";
        }

        return state.matchedLocation;
      });
});