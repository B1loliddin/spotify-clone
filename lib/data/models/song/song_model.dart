import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';

class SongModel extends SongEntity {
  const SongModel({
    required super.title,
    required super.artist,
    required super.duration,
    required super.releaseDate,
    required super.coverDownloadUrl,
    required super.songDownloadUrl,
    required super.coverImageFormat,
  });

  factory SongModel.fromJson(Map<String, Object?> json) {
    final String title = json['title'] as String;
    final String artist = json['artist'] as String;
    final num duration = json['duration'] as num;
    final Timestamp releaseDate = json['release_date'] as Timestamp;
    final String? coverDownloadUrl = json['cover_download_url'] as String?;
    final String? songDownloadUrl = json['song_download_url'] as String?;
    final String coverImageFormat = json['cover_image_format'] as String;

    return SongModel(
      title: title,
      artist: artist,
      duration: duration,
      releaseDate: releaseDate,
      coverDownloadUrl: coverDownloadUrl,
      songDownloadUrl: songDownloadUrl,
      coverImageFormat: coverImageFormat,
    );
  }

  @override
  String toString() {
    return 'SongModel{coverDownloadUrl: $coverDownloadUrl, songDownloadUrl: $songDownloadUrl}';
  }

  SongModel copyWith({
    String? title,
    String? artist,
    num? duration,
    Timestamp? releaseDate,
    String? coverDownloadUrl,
    String? songDownloadUrl,
    String? coverImageFormat,
  }) {
    return SongModel(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      coverDownloadUrl: coverDownloadUrl ?? this.coverDownloadUrl,
      songDownloadUrl: songDownloadUrl ?? this.songDownloadUrl,
      coverImageFormat: coverImageFormat ?? this.coverImageFormat,
    );
  }
}
