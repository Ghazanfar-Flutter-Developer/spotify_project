import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/sources/songs/songs_firebase_services.dart';
import 'package:spotify_project/domain/repository/songs/songs_repository.dart';
import 'package:spotify_project/service_locator.dart';

class SongsRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongsFirebaseServices>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongsFirebaseServices>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavouriteSong(String songId) async {
    return await sl<SongsFirebaseServices>().addOrRemoveFavouriteSong(songId);
  }

  @override
  Future<bool> isFavouriteSong(String songId) async {
    return await sl<SongsFirebaseServices>().isFavouriteSong(songId);
  }

  @override
  Future<Either> getUserFavouriteSongs() async {
    return await sl<SongsFirebaseServices>().getUserFavouriteSongs();
  }
}
