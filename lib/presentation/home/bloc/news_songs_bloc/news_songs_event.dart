part of 'news_songs_bloc.dart';

@immutable
sealed class NewsSongsEvent {
  const NewsSongsEvent();
}

final class NewsSongsGetNewsSongs extends NewsSongsEvent {
  const NewsSongsGetNewsSongs();
}
