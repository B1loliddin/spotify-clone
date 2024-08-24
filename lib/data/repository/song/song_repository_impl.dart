import 'package:spotify_clone/core/errors/failure.dart';
import 'package:spotify_clone/core/errors/server_exception.dart';
import 'package:spotify_clone/core/resources/data_state.dart';
import 'package:spotify_clone/data/datasources/song/song_remote_data_source.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/domain/repository/song/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource songRemoteDataSource;

  const SongRepositoryImpl({required this.songRemoteDataSource});

  @override
  Future<DataState<List<SongEntity>>> getNewsSongs() async {
    try {
      final songs = await songRemoteDataSource.getNewsSongs();

      return DataSuccess(songs);
    } on ServerException catch (e) {
      return DataFailed(Failure(e.message));
    }
  }

  @override
  Future<DataState<List<SongEntity>>> getPlaylist() async {
    try {
      final songs = await songRemoteDataSource.getPlaylist();

      return DataSuccess(songs);
    } on ServerException catch (e) {
      return DataFailed(Failure(e.message));
    }
  }
}
