import 'package:spotify_project/domain/entities/songs/songs_entity.dart';

abstract class PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongsEntity> songs;
  PlayListLoaded({required this.songs});
}

class PlayListLoadFailure extends PlayListState {}
