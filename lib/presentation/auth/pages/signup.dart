import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/widgets/appbar/base_app_bar.dart';
import 'package:spotify_project/common/widgets/button/base_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify_project/presentation/auth/pages/signin.dart';
import 'package:spotify_project/presentation/home/pages/home_page.dart';
import 'package:spotify_project/service_locator.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: SvgPicture.asset(
        AppVectors.logo,
        height: 40,
        width: 40,
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 50),
              _fullNameField(context),
              const SizedBox(height: 20),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 20),
              BaseAppButton(
                title: "Create Account",
                onTap: () async {
                  var result = await sl<SignupUsecase>().call(
                      params: CreateUserReq(
                    fullName: _fullnameController.text.toString(),
                    email: _emailController.text.toString(),
                    password: _passwordController.text.toString(),
                  ));
                  result.fold(
                    (l) {
                      var snackbar = SnackBar(
                        content: Text(l),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    (r) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _signInText(context),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _fullnameController,
      decoration: const InputDecoration(hintText: 'Full Name')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      obscuringCharacter: '*',
      decoration: const InputDecoration(hintText: 'Enter password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Do you have an Account?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ));
            },
            child: const Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
