import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  void updateTemporaryPosition(double value) {
    songPosition = Duration(seconds: value.toInt());

    emit(SongPlayerLoaded());
  }

  void seekToPosition(double value) {
    final newPosition = Duration(seconds: value.toInt());

    audioPlayer.seek(newPosition);

    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    debugPrint(url);

    try {
      await audioPlayer.setUrl(url);

      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void playOrPauseSong() async {
    if (audioPlayer.playing) {
      await audioPlayer.stop();
    } else {
      await audioPlayer.play();
    }

    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
