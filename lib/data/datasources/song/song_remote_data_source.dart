import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:spotify_clone/core/errors/server_exception.dart';
import 'package:spotify_clone/data/models/song/song_model.dart';

abstract interface class SongRemoteDataSource {
  const SongRemoteDataSource();

  Future<List<SongModel>> getNewsSongs();

  Future<List<SongModel>> getPlaylist();
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final Reference firebaseStorageReference;

  const SongRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseStorageReference,
  });

  @override
  Future<List<SongModel>> getNewsSongs() async {
    try {
      List<SongModel> songs = [];

      final coversReference = firebaseStorageReference.child('covers');
      final songsReference = firebaseStorageReference.child('songs');
      final QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore
          .collection('songs')
          .orderBy('release_date', descending: true)
          .limit(3)
          .get();

      for (final song in data.docs) {
        SongModel songModel = SongModel.fromJson(song.data());
        final coverDownloadUrl = await coversReference
            .child(
              '/${songModel.artist} ${songModel.title} Cover.${songModel.coverImageFormat}',
            )
            .getDownloadURL();
        final songDownloadUrl = await songsReference
            .child(
              '/${songModel.artist} ${songModel.title} Song.mp3',
            )
            .getDownloadURL();

        songModel = songModel.copyWith(
          coverDownloadUrl: coverDownloadUrl,
          songDownloadUrl: songDownloadUrl,
        );

        songs.add(songModel);
      }

      return songs;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      throw ServerException(e.message ?? '');
    }
  }

  @override
  Future<List<SongModel>> getPlaylist() async {
    try {
      List<SongModel> songs = [];

      final coversReference = firebaseStorageReference.child('covers');
      final QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore
          .collection('songs')
          .orderBy('release_date', descending: true)
          .get();

      for (final song in data.docs) {
        SongModel songModel = SongModel.fromJson(song.data());
        final coverDownloadUrl = await coversReference
            .child(
                '/${songModel.artist} ${songModel.title} Cover.${songModel.coverImageFormat}')
            .getDownloadURL();

        songModel = songModel.copyWith(coverDownloadUrl: coverDownloadUrl);

        songs.add(songModel);
      }

      return songs;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      throw ServerException(e.message ?? '');
    }
  }
}
