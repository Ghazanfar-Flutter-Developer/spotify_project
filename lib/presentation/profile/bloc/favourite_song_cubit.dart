import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/entities/songs/songs_entity.dart';
import 'package:spotify_project/domain/usecases/songs/get_favourite_songs_usecase.dart';
import 'package:spotify_project/presentation/profile/bloc/favourite_song_state.dart';
import 'package:spotify_project/service_locator.dart';

class FavouriteSongCubit extends Cubit<FavouriteSongState> {
  FavouriteSongCubit() : super(FavouriteSongLoading());

  List<SongsEntity> favouritesongs = [];

  Future<void> getFavouriteSongs() async {
    var result = await sl<GetFavouriteSongsUsecase>().call();

    result.fold(
      (l) {
        emit(
          FavouriteSongFailure(),
        );
      },
      (r) {
        favouritesongs = r;
        emit(
          FavouriteSongLoaded(favouriteSong: favouritesongs),
        );
      },
    );
  }
}
