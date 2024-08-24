import 'package:flutter/material.dart';
import 'package:spotify_clone/common/helpers/check_theme_mode.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? action;
  final bool hideBackButton;

  const BasicAppBar({
    super.key,
    this.title = const Text(''),
    this.action,
    this.hideBackButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    void navigateToThemeModeSelectionPage() => Navigator.pop(context);

    return AppBar(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      leadingWidth: 65,
      title: title,
      centerTitle: true,
      leading: hideBackButton
          ? null
          : Align(
              alignment: Alignment.centerRight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? AppColors.white.withOpacity(0.03)
                      : AppColors.black.withOpacity(0.03),
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: navigateToThemeModeSelectionPage,
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 22,
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
      actions: [action ?? const SizedBox.shrink()],
    );
  }
}
