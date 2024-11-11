import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spec_app/app/enums/model_state.dart';
import 'package:spec_app/app/widgets/base_drop_down_field.dart';
import 'package:spec_app/app/widgets/base_text_from_field.dart';
import 'package:spec_app/features/login/provider/login_provider.dart';
import 'package:spec_app/features/users/data/model/user_model.dart';

class LoginLayout extends ConsumerWidget {
  const LoginLayout({super.key});

  static final _formKey = GlobalKey<FormState>();
  static final FocusNode _pswFocus = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height / 3,
                child: Image(
                  image: AssetImage("assets/logos/specdoor-1-no-bg.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutofillGroup(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          BaseDropdownField<UserModel>(
                            labelText: 'Felhasználó',
                            prefixIcon: Icon(Icons.person),
                            items: ref
                                .watch(loginDataProvider)
                                .users
                                .map((e) => DropdownMenuItem<UserModel>(
                                      value: e,
                                      child: Text(e.name.toString()),
                                    ))
                                .toList(),
                            onChanged: (u) {
                              if (u == null) {
                                return;
                              }
                              _pswFocus.requestFocus();
                              ref.read(loginDataProvider.notifier).setUser(u);
                            },
                          ),
                          BaseTextFormField(
                            initialValue: ref.watch(loginDataProvider).password,
                            labelText: 'Jelszó',
                            textInputAction: TextInputAction.go,
                            errorText:
                                ref.watch(loginDataProvider).modelState == ModelState.error ? "Hibás jelszó" : null,
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            isPasswordField: true,
                            obscureText: true,
                            focusNode: _pswFocus,
                            autofillHints: [AutofillHints.password],
                            validator: (String? text) {
                              if (text == null || text.isEmpty) {
                                return "Nem lehet üres";
                              }
                              return null;
                            },
                            onFieldSubmitted: (text) => login(ref, context),
                            onChanged: (String text) => ref.watch(loginDataProvider.notifier).setPassword(text),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Theme.of(context).secondaryHeaderColor,
                                      backgroundColor: Theme.of(context).primaryColor),
                                  onPressed: () => login(ref, context),
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
        ),
      ),
    );
  }

  Future<void> login(WidgetRef ref, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await ref.read(loginDataProvider.notifier).login().then((value) async =>
          ref.read(loginDataProvider).modelState == ModelState.success && context.mounted
              ? context.replace("/projects")
              : null);
    }
  }
}
