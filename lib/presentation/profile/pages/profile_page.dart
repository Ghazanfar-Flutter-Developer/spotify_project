import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/widgets/appbar/base_app_bar.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify_project/presentation/choose_mode/bloc/theme_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Access the current theme mode from ThemeCubit
    ThemeMode currentThemeMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      appBar: const BaseAppBar(
        backgroundColor: AppColors.darkGrey,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(height: 15),
          _favouriteSongsGetting(context, currentThemeMode),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile.png',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'developercloud@gmail.com',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Text(
            'Ghazanfar Hussain',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _favouriteSongsGetting(
      BuildContext context, ThemeMode currentThemeMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Spotify Features",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupOrSignin(),
                ),
              );
            },
            title: const Text(
              'Log Out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(
              Icons.logout,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: currentThemeMode == ThemeMode.dark,
                  onChanged: (bool isDarkMode) {
                    if (isDarkMode) {
                      context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                    } else {
                      context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
