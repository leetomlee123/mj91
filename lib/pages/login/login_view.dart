import 'package:flutter/material.dart';
import 'package:mj91/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("登录"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            _buildLabel(),
            _buildInputUserName(),
            _buildInputPassword(),
            _buildLoginBtn()
          ],
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return SizedBox(
      child: Center(
        child: Text("Welcome to login"),
      ),
    );
  }

  Widget _buildInputUserName() {
    return TextField(
      controller: controller.userNameController,
      decoration: InputDecoration(prefixIcon: Icon(Icons.person)),
    );
  }

  Widget _buildInputPassword() {
    return TextField(
      controller: controller.passwordController,
      decoration: InputDecoration(prefixIcon: Icon(Icons.lock)),
    );
  }

  Widget _buildLoginBtn() {
    return TextButton(onPressed: () => controller.login(), child: Text("登录"));
  }
}
