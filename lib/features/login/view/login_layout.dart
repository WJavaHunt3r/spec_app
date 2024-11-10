import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/features/login/provider/login_provider.dart';

class LoginLayout extends ConsumerWidget {
  const LoginLayout({super.key});

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/logos/specdoor-1-no-bg.png"),
            fit: BoxFit.fitWidth,
          ),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BaseTextFormField(
                        initialValue: ref.watch(loginDataProvider).username,
                        labelText: 'Karbantartó',
                        validator: (String? text) {
                          if (text == null || text.isEmpty) {
                            return "Nem lehet üres";
                          }
                          return null;
                        },
                        onChanged: (String text) => ref.watch(loginDataProvider.notifier).setUsername(text),
                      ),
                      BaseTextFormField(
                        initialValue: ref.watch(loginDataProvider).password,
                        labelText: 'Helyszín',
                        validator: (String? text) {
                          if (text == null || text.isEmpty) {
                            return "Nem lehet üres";
                          }
                          return null;
                        },
                        onChanged: (String text) => ref.watch(loginDataProvider.notifier).setPassword(text),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(context).secondaryHeaderColor,
                                backgroundColor: Theme.of(context).primaryColor
                              ),
                              onPressed: () { },
                              child: Text('Bejelentkezés'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
