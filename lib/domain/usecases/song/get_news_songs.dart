import 'package:spotify_clone/core/resources/data_state.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/domain/repository/song/song_repository.dart';

class GetNewsSongs implements UseCase<List<SongEntity>, NoParams> {
  final SongRepository songRepository;

  const GetNewsSongs({required this.songRepository});

  @override
  Future<DataState> call(NoParams params) async =>
      await songRepository.getNewsSongs();
}
