import 'package:get_it/get_it.dart';
import 'package:spotify_project/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_project/data/repository/songs/songs_repository_impl.dart';
import 'package:spotify_project/data/sources/auth/auth_firebase_services.dart';
import 'package:spotify_project/data/sources/songs/songs_firebase_services.dart';
import 'package:spotify_project/domain/repository/auth/auth_repository.dart';
import 'package:spotify_project/domain/repository/songs/songs_repository.dart';
import 'package:spotify_project/domain/usecases/auth/get_user_usecase.dart';
import 'package:spotify_project/domain/usecases/auth/signin_usecase.dart';
import 'package:spotify_project/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify_project/domain/usecases/songs/add_or_remove_song_favourite.dart';
import 'package:spotify_project/domain/usecases/songs/get_favourite_songs_usecase.dart';
import 'package:spotify_project/domain/usecases/songs/get_news_songs.dart';
import 'package:spotify_project/domain/usecases/songs/get_play_list.dart';
import 'package:spotify_project/domain/usecases/songs/is_favourite_song.dart';

GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton(() => SongsRepositoryImpl());

  sl.registerSingleton<AuthFirebaseServices>(
    AuthFirebaseServicesImpl(),
  );

  sl.registerSingleton<SongsFirebaseServices>(
    SongFirebaseServiceImpl(),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<SongsRepository>(
    SongsRepositoryImpl(),
  );

  sl.registerSingleton<SignupUsecase>(
    SignupUsecase(),
  );

  sl.registerSingleton<SigninUsecase>(
    SigninUsecase(),
  );

  sl.registerSingleton<GetNewsSongsUsecase>(
    GetNewsSongsUsecase(),
  );

  sl.registerSingleton<GetPlayListUsecase>(
    GetPlayListUsecase(),
  );

  sl.registerSingleton<AddOrRemoveSongFavourite>(
    AddOrRemoveSongFavourite(),
  );

  sl.registerSingleton<IsFavouriteSongUseCase>(
    IsFavouriteSongUseCase(),
  );

  sl.registerSingleton<GetUserUsecase>(
    GetUserUsecase(),
  );

  sl.registerSingleton<GetFavouriteSongsUsecase>(
    GetFavouriteSongsUsecase(),
  );
}
