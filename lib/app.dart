import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/core/configs/theme/app_theme.dart';
import 'package:spotify_clone/init_dependencies.main.dart';
import 'package:spotify_clone/presentation/auth/bloc/auth_bloc.dart';
import 'package:spotify_clone/presentation/auth/pages/register_page.dart';
import 'package:spotify_clone/presentation/auth/pages/sign_in_page.dart';
import 'package:spotify_clone/presentation/auth/pages/sign_up_page.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_bloc/news_songs_bloc.dart';
import 'package:spotify_clone/presentation/home/bloc/playist/playlist_bloc.dart';
import 'package:spotify_clone/presentation/home/pages/home_page.dart';
import 'package:spotify_clone/presentation/intro/pages/get_started_page.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player_page.dart';
import 'package:spotify_clone/presentation/splash/pages/splash_page.dart';
import 'package:spotify_clone/presentation/theme_mode_selection/bloc/theme_mode_cubit.dart';
import 'package:spotify_clone/presentation/theme_mode_selection/pages/theme_mode_selection_page.dart';

class SpotifyClone extends StatelessWidget {
  const SpotifyClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeModeCubit>(create: (_) => serviceLocator()),
        BlocProvider<AuthBloc>(create: (_) => serviceLocator()),
        BlocProvider<NewsSongsBloc>(create: (_) => serviceLocator()),
        BlocProvider<PlaylistBloc>(create: (_) => serviceLocator()),
        BlocProvider<SongPlayerCubit>(create: (_) => serviceLocator()),
      ],
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (_, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routes: {
              '/': (_) => const SplashPage(),
              '/get_started_page': (_) => const GetStartedPage(),
              '/theme_mode_selection_page': (_) => const ThemeModeSelectionPage(),
              '/register_page': (_) => const RegisterPage(),
              '/sign_up_page': (_) => const SignUpPage(),
              '/sign_in_page': (_) => const SignInPage(),
              '/home_page': (_) => const HomePage(),
              '/song_player_page': (_) => const SongPlayerPage(),
            },
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
