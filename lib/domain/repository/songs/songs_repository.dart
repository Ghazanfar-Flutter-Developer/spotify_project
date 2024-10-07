import 'package:dartz/dartz.dart';

abstract class SongsRepository {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavouriteSong(String songId);
  Future<bool> isFavouriteSong(String songId);
  Future<Either> getUserFavouriteSongs();
}
