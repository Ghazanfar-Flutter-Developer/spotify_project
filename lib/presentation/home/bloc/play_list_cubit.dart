import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/songs/get_play_list.dart';
import 'package:spotify_project/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_project/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnSongs = await sl<GetPlayListUsecase>().call();

    returnSongs.fold(
      (l) {
        emit(PlayListLoadFailure());
      },
      (data) {
        emit(PlayListLoaded(songs: data));
      },
    );
  }
}
