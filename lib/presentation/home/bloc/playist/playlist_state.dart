part of 'playlist_bloc.dart';

@immutable
sealed class PlaylistState {
  const PlaylistState();
}

final class PlaylistInitial extends PlaylistState {
  const PlaylistInitial();
}

final class PlaylistLoading extends PlaylistState {
  const PlaylistLoading();
}

final class PlaylistFailure extends PlaylistState {
  final String message;

  const PlaylistFailure({required this.message});
}

final class PlaylistGetPlaylistSuccess extends PlaylistState {
  final List<SongEntity> playlist;

  const PlaylistGetPlaylistSuccess({required this.playlist});
}
