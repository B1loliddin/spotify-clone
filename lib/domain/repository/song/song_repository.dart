import 'package:spotify_clone/core/resources/data_state.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';

abstract interface class SongRepository {
  const SongRepository();

  Future<DataState<List<SongEntity>>> getNewsSongs();
  Future<DataState<List<SongEntity>>> getPlaylist();
}
