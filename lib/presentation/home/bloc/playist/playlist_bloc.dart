import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:spotify_clone/core/resources/data_state.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/domain/usecases/song/get_playlist.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final GetPlaylist _getPlaylist;

  PlaylistBloc({required GetPlaylist getPlaylist})
      : _getPlaylist = getPlaylist,
        super(const PlaylistInitial()) {
    on<PlaylistEvent>((_, emit) => emit(const PlaylistLoading()));
    on<PlaylistGetPlaylist>(_onGetPlaylist);
  }

  void _onGetPlaylist(
    PlaylistGetPlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    final playlist = await _getPlaylist(const NoParams());

    if (playlist is DataSuccess) {
      emit(PlaylistGetPlaylistSuccess(playlist: playlist.data));
    } else if (playlist is DataFailed) {
      emit(PlaylistFailure(message: playlist.failure!.message));
    }
  }
}
