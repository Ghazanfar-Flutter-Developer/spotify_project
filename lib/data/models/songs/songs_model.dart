import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_project/domain/entities/songs/songs_entity.dart';

class SongsModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavourite;
  String? songId;

  SongsModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavourite,
    required this.songId,
  });

  SongsModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
  }
}

extension SongModelX on SongsModel {
  SongsEntity toEntity() {
    return SongsEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
      isFavourite: isFavourite!,
      songId: songId!,
    );
  }
}
