import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/button/base_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/auth/pages/signin.dart';
import 'package:spotify_project/presentation/auth/pages/signup.dart';
import 'package:spotify_project/presentation/home/pages/home_page.dart';

import '../../../common/widgets/appbar/base_app_bar.dart';

class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({super.key});

  // Function to check if the user is authenticated
  Future<bool> _checkIfSignedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkIfSignedIn(), // Check if the user is signed in
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while checking the auth state
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data == true) {
          // If the user is signed in, navigate to the home screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomePage()), // Your home screen
            );
          });
        }

        // If the user is not signed in, show the sign-in/sign-up screen
        return Scaffold(
          body: Stack(
            children: [
              const BaseAppBar(),
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  AppVectors.topPattern,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  AppVectors.bottomPattern,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  AppImages.authBg,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppVectors.logo,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Enjoy Listening to Music",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur. Nulla facilisi. Integer facilisi odio.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: BaseAppButton(
                              height: 50,
                              title: "Register",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(),
                                    ));
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
