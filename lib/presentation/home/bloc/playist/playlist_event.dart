part of 'playlist_bloc.dart';

@immutable
sealed class PlaylistEvent {
  const PlaylistEvent();
}

final class PlaylistGetPlaylist extends PlaylistEvent {
  const PlaylistGetPlaylist();
}
