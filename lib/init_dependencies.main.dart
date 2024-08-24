import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify_clone/data/datasources/auth/auth_remote_data_source.dart';
import 'package:spotify_clone/data/datasources/song/song_remote_data_source.dart';
import 'package:spotify_clone/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_clone/data/repository/song/song_repository_impl.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone/domain/repository/song/song_repository.dart';
import 'package:spotify_clone/domain/usecases/auth/user_sign_in.dart';
import 'package:spotify_clone/domain/usecases/auth/user_sign_up.dart';
import 'package:spotify_clone/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_clone/domain/usecases/song/get_playlist.dart';
import 'package:spotify_clone/presentation/auth/bloc/auth_bloc.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_bloc/news_songs_bloc.dart';
import 'package:spotify_clone/presentation/home/bloc/playist/playlist_bloc.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_clone/presentation/theme_mode_selection/bloc/theme_mode_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorageReference = FirebaseStorage.instance.ref();

  /// Firebase
  serviceLocator.registerFactory<FirebaseAuth>(() => firebaseAuth);

  serviceLocator.registerFactory<FirebaseFirestore>(() => firebaseFirestore);

  serviceLocator.registerFactory<Reference>(() => firebaseStorageReference);

  /// Bloc/Cubit
  serviceLocator.registerLazySingleton<ThemeModeCubit>(
    () => ThemeModeCubit(),
  );
}

Future<void> _initAuth() async {
  /// Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: serviceLocator(),
      firebaseFirestore: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<SongRemoteDataSource>(
    () => SongRemoteDataSourceImpl(
      firebaseFirestore: serviceLocator(),
      firebaseStorageReference: serviceLocator(),
    ),
  );

  /// Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory<SongRepository>(
    () => SongRepositoryImpl(songRemoteDataSource: serviceLocator()),
  );

  /// Use Case
  serviceLocator.registerFactory<UserSignUp>(
    () => UserSignUp(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory<UserSignIn>(
    () => UserSignIn(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory<GetNewsSongs>(
    () => GetNewsSongs(songRepository: serviceLocator()),
  );

  serviceLocator.registerFactory<GetPlaylist>(
    () => GetPlaylist(songRepository: serviceLocator()),
  );

  /// Bloc
  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<NewsSongsBloc>(
    () => NewsSongsBloc(getNewsSongs: serviceLocator()),
  );

  serviceLocator.registerFactory<PlaylistBloc>(
    () => PlaylistBloc(getPlaylist: serviceLocator()),
  );

  serviceLocator.registerFactory<SongPlayerCubit>(
    () => SongPlayerCubit(),
  );
}
