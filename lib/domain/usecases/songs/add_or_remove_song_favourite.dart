import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/songs/songs_repository.dart';
import 'package:spotify_project/service_locator.dart';

class AddOrRemoveSongFavourite implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavouriteSong(params!);
  }
}
