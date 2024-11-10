import 'package:flutter/material.dart';
import 'package:spec_app/features/login/view/login_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(padding: EdgeInsets.all(8), child: LoginLayout(),),
    );
  }
}
