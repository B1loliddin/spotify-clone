import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:spotify_clone/core/resources/data_state.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/domain/usecases/song/get_news_songs.dart';

part 'news_songs_event.dart';
part 'news_songs_state.dart';

class NewsSongsBloc extends Bloc<NewsSongsEvent, NewsSongsState> {
  final GetNewsSongs _getNewsSongs;

  NewsSongsBloc({required GetNewsSongs getNewsSongs})
      : _getNewsSongs = getNewsSongs,
        super(const NewsSongsInitial()) {
    on<NewsSongsEvent>((_, emit) => emit(const NewsSongsLoading()));
    on<NewsSongsGetNewsSongs>(_onGetNewsSongs);
  }

  void _onGetNewsSongs(
    NewsSongsGetNewsSongs event,
    Emitter<NewsSongsState> emit,
  ) async {
    final songs = await _getNewsSongs(const NoParams());

    if (songs is DataSuccess) {
      emit(NewsSongsGetNewsSongsSuccess(songs: songs.data!));
    } else if (songs is DataFailed) {
      emit(NewsSongsFailure(message: songs.failure!.message));
    }
  }
}
