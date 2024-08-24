import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigateToGetStartedPage();
  }

  Future<void> navigateToGetStartedPage() async {
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      /// TODO: Fix navigator
      Navigator.pushReplacementNamed(context, '/get_started_page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ff0d0c0c,
      body: Center(
        child: SvgPicture.asset(AppVectors.spotifyLogo),
      ),
    );
  }
}
