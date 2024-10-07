import 'package:flutter/material.dart';

class BaseAppButton extends StatelessWidget {
  final String title;
  final double? height;
  final VoidCallback onTap;
  const BaseAppButton({
    super.key,
    required this.title,
    this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style:
          ElevatedButton.styleFrom(minimumSize: Size.fromHeight(height ?? 80)),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
