import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/songs/get_news_songs.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_cubit_state.dart';
import 'package:spotify_project/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUsecase>().call();

    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (data) {
        emit(NewsSongsLoaded(songs: data));
      },
    );
  }
}
