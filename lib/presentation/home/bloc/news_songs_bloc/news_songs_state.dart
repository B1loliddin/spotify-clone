part of 'news_songs_bloc.dart';

@immutable
sealed class NewsSongsState {
  const NewsSongsState();
}

final class NewsSongsInitial extends NewsSongsState {
  const NewsSongsInitial();
}

final class NewsSongsLoading extends NewsSongsState {
  const NewsSongsLoading();
}

final class NewsSongsFailure extends NewsSongsState {
  final String message;

  const NewsSongsFailure({required this.message});
}

final class NewsSongsGetNewsSongsSuccess extends NewsSongsState {
  final List<SongEntity> songs;

  const NewsSongsGetNewsSongsSuccess({required this.songs});
}
