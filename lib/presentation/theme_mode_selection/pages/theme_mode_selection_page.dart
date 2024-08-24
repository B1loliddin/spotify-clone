import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/theme_mode_selection/bloc/theme_mode_cubit.dart';

class ThemeModeSelectionPage extends StatelessWidget {
  const ThemeModeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phonePadding = MediaQuery.of(context).padding;

    void changeThemeMode(ThemeMode themeMode) {
      context.read<ThemeModeCubit>().updateTheme(themeMode);

      // if (themeMode == ThemeMode.light) {
      //   SystemChrome.setSystemUIOverlayStyle(
      //     SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      //   );
      // } else {
      //   SystemChrome.setSystemUIOverlayStyle(
      //       SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
      // }
    }

    void navigateToRegisterPage() =>
        Navigator.pushNamed(context, '/register_page');

    return Scaffold(
      body: Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.chooseModeBG),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            ),
          ),

          /// #
          ColoredBox(
            color: Colors.black.withOpacity(0.15),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            ),
          ),

          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(
                top: phonePadding.top + 15,
                bottom: phonePadding.bottom + 15,
              ),
              child: Column(
                children: [
                  /// #
                  SvgPicture.asset(AppVectors.spotifyLogo),
                  const Spacer(),

                  /// #
                  const Text(
                    'Choose Mode',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  /// #
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          /// #
                          GestureDetector(
                            onTap: () => changeThemeMode(ThemeMode.dark),
                            child: ClipOval(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: ColoredBox(
                                  color: AppColors.blurColor.withOpacity(0.5),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppVectors.moon,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          /// #
                          const Text(
                            'Dark Mode',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 40),

                      /// #
                      Column(
                        children: [
                          /// #
                          GestureDetector(
                            onTap: () => changeThemeMode(ThemeMode.light),
                            child: ClipOval(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: ColoredBox(
                                  color: AppColors.blurColor.withOpacity(0.5),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppVectors.sun,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          /// #
                          const Text(
                            'Light Mode',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  /// #
                  BasicAppButton(
                    onPressed: navigateToRegisterPage,
                    textFontWeight: FontWeight.bold,
                    text: 'Continue',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
