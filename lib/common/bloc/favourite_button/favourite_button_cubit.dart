import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/bloc/favourite_button/favourite_button_state.dart';
import 'package:spotify_project/domain/usecases/songs/add_or_remove_song_favourite.dart';
import 'package:spotify_project/service_locator.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState> {
  FavouriteButtonCubit() : super(FavouriteButtonInitial());

  void favouriteButtonUpdate(String songId) async {
    var result = await sl<AddOrRemoveSongFavourite>().call(
      params: songId,
    );

    result.fold(
      (l) {},
      (isfavourite) {
        emit(
          FavouriteButtonUpdate(
            isFavourite: isfavourite,
          ),
        );
      },
    );
  }
}
