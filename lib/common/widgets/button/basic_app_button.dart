import 'package:flutter/material.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final FontWeight textFontWeight;
  final double height;

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textFontWeight = FontWeight.w400,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width, height),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: textFontWeight,
          color: AppColors.white,
        ),
      ),
    );
  }
}
