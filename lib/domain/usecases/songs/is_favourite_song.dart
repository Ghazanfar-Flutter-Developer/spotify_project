import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/songs/songs_repository.dart';
import 'package:spotify_project/service_locator.dart';

class IsFavouriteSongUseCase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavouriteSong(params!);
  }
}
