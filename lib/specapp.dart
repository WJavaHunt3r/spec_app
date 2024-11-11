import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/providers/routerProvider.dart';

class SpecApp extends ConsumerWidget {
  const SpecApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
        title: 'SpecApp',
        debugShowCheckedModeBanner: false,
        locale: const Locale("hu", "HU"),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFD32F2F)),
          useMaterial3: true,
        ),
        routerConfig: router,
        scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>());
  }
}
