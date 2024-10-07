import 'package:flutter/material.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool hideBack;
  final Widget? action;
  final Color? backgroundColor;
  const BaseAppBar({
    super.key,
    this.hideBack = false,
    this.title,
    this.backgroundColor,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      title: title ?? const Text(''),
      centerTitle: true,
      elevation: 0,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.greyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
            ),
      actions: [
        action ?? Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
