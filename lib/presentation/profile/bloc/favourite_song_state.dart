import 'package:spotify_project/domain/entities/songs/songs_entity.dart';

abstract class FavouriteSongState {}

class FavouriteSongLoading extends FavouriteSongState {}

class FavouriteSongLoaded extends FavouriteSongState {
  final List<SongsEntity> favouriteSong;
  FavouriteSongLoaded({required this.favouriteSong});
}

class FavouriteSongFailure extends FavouriteSongState {}
