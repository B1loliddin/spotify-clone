part of 'song_player_cubit.dart';

abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {}

class SongPlayerPositionUpdated extends SongPlayerState {}

class SongPlayerFailure extends SongPlayerState {}
