import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/widgets/appbar/base_app_bar.dart';
import 'package:spotify_project/common/widgets/button/base_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/domain/usecases/auth/signin_usecase.dart';
import 'package:spotify_project/presentation/auth/pages/signup.dart';
import 'package:spotify_project/presentation/home/pages/home_page.dart';
import 'package:spotify_project/service_locator.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
              _signInHeading(),
              const SizedBox(height: 50),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 20),
              BaseAppButton(
                title: "Sign In",
                onTap: () async {
                  var result = await sl<SigninUsecase>().call(
                    params: SignUserReq(
                      email: _email.text.trim(),
                      password: _password.text,
                    ),
                  );
                  result.fold(
                    (errorMessage) {
                      if (errorMessage.isNotEmpty) {
                        var snackbar = SnackBar(
                          content: Text(errorMessage),
                          behavior: SnackBarBehavior.floating,
                          // Optional: Highlight error
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      } else {
                        var snackbar = const SnackBar(
                          content: Text('An unexpected error occurred.'),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    (successMessage) {
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
      bottomNavigationBar: _registerText(context),
    );
  }

  Widget _signInHeading() {
    return const Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Widget _fullNameField(BuildContext context) {
  //   return TextFormField(
  //     decoration: const InputDecoration(hintText: 'Full Name')
  //         .applyDefaults(Theme.of(context).inputDecorationTheme),
  //   );
  // }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(hintText: 'Enter UserName or Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _password,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      obscuringCharacter: '*',
      decoration: const InputDecoration(hintText: 'Enter password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _registerText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an Account?",
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
                    builder: (context) => Signup(),
                  ));
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
