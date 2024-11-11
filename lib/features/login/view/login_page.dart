import 'package:flutter/material.dart';
import 'package:spec_app/features/login/view/login_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: LoginLayout(),
      ),
    );
  }
}
