import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/helpers/check_theme_mode.dart';
import 'package:spotify_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToSignUpPage() =>
        Navigator.pushNamed(context, '/sign_up_page');

    void navigateToSignInPage() =>
        Navigator.pushNamed(context, '/sign_in_page');

    return Scaffold(
      body: Stack(
        children: [
          /// #
          const BasicAppBar(),

          /// #
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),

          /// #
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),

          /// #
          const Align(
            alignment: Alignment.bottomLeft,
            child: Image(image: AssetImage(AppImages.authBG)),
          ),

          /// #
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.spotifyLogo),
                  const SizedBox(height: 55),

                  /// #
                  const Text(
                    'Enjoy listening to music',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// #
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),

                  /// #
                  Row(
                    children: [
                      Expanded(
                        child: BasicAppButton(
                          onPressed: navigateToSignUpPage,
                          text: 'Register',
                          textFontWeight: FontWeight.w500,
                          height: 70,
                        ),
                      ),
                      const SizedBox(width: 20),

                      /// #
                      Expanded(
                        child: TextButton(
                          onPressed: navigateToSignInPage,
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: context.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
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
  }
}
