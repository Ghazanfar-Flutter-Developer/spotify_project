import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/songs/songs_repository.dart';
import 'package:spotify_project/service_locator.dart';

class GetPlayListUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getPlayList();
  }
}
